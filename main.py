# Imports
import os
import json
import pymongo
import mysql.connector
from dotenv import load_dotenv
from mysql.connector.abstracts import MySQLConnectionAbstract
from mysql.connector.pooling import PooledMySQLConnection

# Variables
path_here = os.path.dirname(__file__)
with open(f"{path_here}/models/attribute_match.json", "r") as f:
    attributes_mongo_mysql = json.load(f)

with open(f"{path_here}/models/tables_match.json", "r") as f:
    tables_mongo_mysql = json.load(f)

# Functions

def create_attribute_list(table: str):
    mongo_attr = list(attributes_mongo_mysql[table].keys())
    listOfAttr = list(attributes_mongo_mysql[table].values())
    fillers = "%s " * len(listOfAttr)
    fillers = fillers.rstrip().replace(' ', ', ')
    return  ", ".join(mongo_attr), ", ".join(listOfAttr), fillers
    return mongo_client, mysql_conn
def connect(mongodb_uri: str, mysql_config: dict):
    mongo_client = pymongo.MongoClient(mongodb_uri)
    # Create Database if it doesn't already exist
    mysql_conn_creator = mysql.connector.connect(**{
        'host': os.getenv('MARIADB_URL'),
        'user': os.getenv('MARIADB_USER'),
        'password': os.getenv('MARIADB_PASSWORD'),
    })
    creation_cursor = mysql_conn_creator.cursor()
    creation_cursor.execute(f"CREATE DATABASE IF NOT EXISTS {mysql_config['database']}")
    creation_cursor.close()
    mysql_conn_creator.close()
    mysql_conn = mysql.connector.connect(**mysql_config)
    print("Connected to MongoDB and MySQL")
    return mongo_client, mysql_conn
def close(mysql_conn, mongo_client):
    closing_message = "Closing connections..."
    mysql_conn.close()
    mongo_client.close()
    print(closing_message)
def document_mongo_attr(document: dict, attr: str):
    all_attr = attr.split(", ")
    resulting_list = [str(document.get(attribute, "")) for attribute in all_attr]
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
                # print(command)
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
            print(f"Connected to DB {mongo_db}")
            mongo_client, mysql_conn = connect(mongo_uri, mysql_config)
            create_with_file(mysql_conn, 'GS-SODECI.sql')
            for collection in tables_mongo_mysql:
                transfer(mongo_client, mongo_db, collection, mysql_conn)
        except Exception as e:
            print(f"A big error occurred: {e}")
            continue
        finally:
            close(mysql_conn, mongo_client)

# Main
load_dotenv()
mongo_uri = os.getenv('MONGODB_URL')
dbs = os.getenv('MONGODB_SOURCE_DBS').split(',')
mysql_config = {
    'host': os.getenv('MARIADB_URL'),
    'user': os.getenv('MARIADB_USER'),
    'password': os.getenv('MARIADB_PASSWORD'),
    'database': os.getenv('MARIADB_TARGET_DB')
}

if __name__ == '__main__':
    run()
