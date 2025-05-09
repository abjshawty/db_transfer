# Imports
import os
import re
import bson
import json
import pymongo
import mysql.connector
from dotenv import load_dotenv
from mysql.connector.abstracts import MySQLConnectionAbstract
from mysql.connector.pooling import PooledMySQLConnection

# Variables
load_dotenv()
path_here = os.path.dirname(__file__)
with open(f"{path_here}/models/attribute_match.json", "r") as f:
    attributes_mongo_mysql = json.load(f)
with open(f"{path_here}/models/tables_match.json", "r") as f:
    tables_mongo_mysql = json.load(f)
mongo_uri = os.getenv('MONGODB_URL')
dbs = os.getenv('MONGODB_SOURCE_DBS').split(',')
mysql_config = {
    'host': os.getenv('MARIADB_URL'),
    'user': os.getenv('MARIADB_USER'),
    'password': os.getenv('MARIADB_PASSWORD'),
    'database': os.getenv('MARIADB_TARGET_DB'),
    'collation': 'utf8mb4_general_ci'
}

# Functions
def create_attribute_list(table: str):
    mongo_attr = list(attributes_mongo_mysql[table].keys())
    listOfAttr = list(attributes_mongo_mysql[table].values())
    fillers = "%s " * len(listOfAttr)
    fillers = fillers.rstrip().replace(' ', ', ')
    return  ", ".join(mongo_attr), ", ".join(listOfAttr), fillers

def connect(mongodb_uri: str, mysql_config: dict):
    mongo_client = pymongo.MongoClient(mongodb_uri)
    # Create Database if it doesn't already exist
    mysql_conn_creator = mysql.connector.connect(**{
        'host': mysql_config["host"],
        'user': mysql_config["user"],
        'password': mysql_config["password"],
        'collation': mysql_config["collation"]
    })
    creation_cursor = mysql_conn_creator.cursor()
    creation_cursor.execute(f"CREATE DATABASE IF NOT EXISTS {mysql_config['database']}")
    creation_cursor.close()
    mysql_conn_creator.close()
    mysql_conn = mysql.connector.connect(**mysql_config)
    print("Connected to MongoDB and MySQL")
    return mongo_client, mysql_conn

def clean_profiles(mysql_conn: PooledMySQLConnection | MySQLConnectionAbstract):
    mysql_cursor = mysql_conn.cursor()
    lock = "LOCK TABLE User WRITE"
    unlock = "UNLOCK TABLES"
    print("Cleaning profiles...")
    mysql_cursor.execute(lock)
    mysql_cursor.execute("UPDATE User SET profileId = NULL")
    mysql_cursor.execute(unlock)
    mysql_conn.commit()
    mysql_cursor.close()

def close(mysql_conn, mongo_client):
    closing_message = "Closing connections..."
    mysql_conn.close()
    mongo_client.close()
    print(closing_message)

def document_mongo_attr(document: dict, attr: str):
    all_attr = attr.split(", ")
    resulting_list = [document.get(attribute, "") for attribute in all_attr]
    resulting_list[0] = str(resulting_list[0])
    for i, e in enumerate(resulting_list):
        if type(e) == list:
            print("AHAHAHAHAHAHAHAHAHAH", e)
            if 2 > len(e) > 0 and type(e[0]) == bson.ObjectId:
                resulting_list[i] = json.dumps([str(x) for x in e])[:255]
            elif len(e) > 0 and type(e[0]) == bson.ObjectId:
                resulting_list[i] = str(e[0])
            else:
                resulting_list[i] = json.dumps(str(e))[:255]
        elif type(e) == bson.ObjectId:
            resulting_list[i] = str(e)
        elif type(e) == str and e == '':
            resulting_list[i] = None
    return tuple(resulting_list)

def transfer(
    mongo_client: pymongo.MongoClient,
    mongo_db: str,
    mongo_collection: str,
    mysql_conn: PooledMySQLConnection | MySQLConnectionAbstract,
    ):
    # Retrive data from MoingoDB
    mongo_data=mongo_client[mongo_db][mongo_collection].find()

    # Transfer data into MySQL
    mysql_cursor=mysql_conn.cursor()
    mongo_keys, sql_keys, fillers = create_attribute_list(mongo_collection)
    lock = f"LOCK TABLE {tables_mongo_mysql[mongo_collection]} WRITE"
    unlock = "UNLOCK TABLES"
    print(f"Working on table {mongo_collection}")
    mysql_cursor.execute(lock);
    for document in mongo_data:
        try:
            sql = f"INSERT INTO {tables_mongo_mysql[mongo_collection]} ({sql_keys}) VALUES ({fillers})"
            values = (document_mongo_attr(document, mongo_keys))
            mysql_cursor.execute(sql, values)
        except mysql.connector.IntegrityError as e:
            if not str(e).__contains__("Duplicate"): print(f"small error occurred: {e}")
            continue
    mysql_cursor.execute(unlock)
    mysql_conn.commit()
    mysql_cursor.close()

def create_with_file(mysql_conn: PooledMySQLConnection | MySQLConnectionAbstract, filename: str):
    # Read the SQL file
    with open(f"{path_here}/sql/{filename}", 'r') as file:
        sql = file.read()
    
    commands = sql.split(";")
    
    mysql_cursor=mysql_conn.cursor()
    # Execute the SQL file
    for command in commands:
        try:
            if command.strip() != '':
                mysql_cursor.execute(command)
        except IOError as e:
            print(f"Command skipped:{e}")
    # Close the cursor
    mysql_cursor.close()
    # Commit changes
    mysql_conn.commit()

def run():
    for db in dbs:
        mongo_db = db.strip()
        try:
            print(f"Connected to MongoDB database {mongo_db}")
            mongo_client, mysql_conn = connect(mongo_uri, mysql_config)
            foreign_cursor = mysql_conn.cursor()
            foreign_cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
            create_with_file(mysql_conn, 'GS-SODECI.sql')
            for collection in tables_mongo_mysql:
                transfer(mongo_client, mongo_db, collection, mysql_conn)
            clean_profiles(mysql_conn)
            foreign_cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
            foreign_cursor.close()
        # except Exception as e:
            # print(f"A big error occurred: {e}")
            # continue
        finally:
            close(mysql_conn, mongo_client)

# Main
if __name__ == '__main__':
    run()
