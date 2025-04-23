# Database Migration Tool for GESICA SODECI

## Dependencies
Via Pip:
- dotenv
- mysql
- mysql-connector-python
- mysqlclient
- pymongo
- python-dotenv

## Models
The models directory contains the following files:
- attribute_match.json(Mapping of attributes between MongoDB and MariaDB)
- tables_match.json(Whitelist of tables to be migrated)

## Helper Files
The sql directory contains files needed to create the database and tables.

## Configuration
Create a .env file in the root directory with the following variables:
- MONGODB_URL(Resource link to the MongoDB database)
- MONGODB_SOURCE_DBS(List of source MongoDB databases separated by commas)
- MARIADB_URL(Resource link to the MariaDB database)
- MARIADB_USER(User name for the MariaDB database)
- MARIADB_PASSWORD(User password for the MariaDB database)
- MARIADB_TARGET_DB(Target database for the MariaDB database)

Find examples in the .env.example file.

## Usage
Install Python 3.13
Install dependencies:
```bash
pip install -r requirements.txt
```
Run the script:
```bash
python main.py
```

## License
This project is not licensed.

# Important Notes
Profiles have been given up on. They were, to say kindly, a bit of a pain.