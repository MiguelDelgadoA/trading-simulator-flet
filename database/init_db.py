import os
import sqlite3

db_path='trading_simulator.sqlite3'
schema_path='schema.sql'

def database_exists():    
    """Check if the database file exists."""
    if not os.path.exists(db_path):
        print(f"Database file '{db_path}' does not exist.")
        conection_db = create_database()
        return conection_db
    else:
        print(f"Database file '{db_path}' already exists.")
        return True

def create_database():
    my_conection = None
    my_cursor = None
    option = False

    try:
        my_conection = sqlite3.connect(db_path)
        my_conection.row_factory = sqlite3.Row
        my_cursor = my_conection.cursor()

        # Read the schema file
        with open(schema_path, 'r') as schema_file:
            schema_sql = schema_file.read()

        my_cursor.executescript(schema_sql)
        my_conection.commit()
        option = True

    except sqlite3.OperationalError as e:
        print(f"Error connecting to the database: {e}")
        option = False

    finally:
        if my_cursor is not None:
            my_cursor.close()
        if my_conection is not None:
            my_conection.close()

    return option
# Check if the database exists
print(database_exists())
# If it doesn't exist, create it