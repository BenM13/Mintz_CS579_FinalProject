"""
Ben Mintz
MET CS579
Final Project
Script to connect to and update local MySQL database.
"""

import os
import mysql.connector

def connect_to_db():
    """
    Connects to local MySQL database.
    Creates returns DB connection object
    """
    db_obj = None
    try:
        db_obj = mysql.connector.connect(
            host='localhost',
            user='root',
            database='sys',
            passwd=os.getenv('MYSQL_PW')
        )
        print("Database connection established.")
    except mysql.connector.Error as e:
        print("Unable to connect to database:")
        print("\t{}".format(e))
        quit()
    return db_obj

def create_cursor(db_obj):
    """
    Takes connection object as argument.
    Creates and returns cursor object.
    """
    db_cur = None
    try:
        db_cur = db_obj.cursor()
        print("Cursor created.")
    except mysql.connector.Error as e:
        print("There was a problem creating the cursor:")
        print("\t{}".format(e))
        print("Exiting...")
        quit()
    return db_cur

def return_item(db_obj, db_cur):
    """
    Takes database object and cursor object as argument
    Executes UPDATE statement on skier_item table
    Changes item_status 'Returned'
    No return
    """
    print("Enter agreement number to be returned:")
    try:
        agreement = int(input("--> "))
    except ValueError:
        print("Must enter an valid integer. \nExiting...")
        quit()
    query = """
        UPDATE skier_item
        SET item_status = 'Returned'
        WHERE agreement = {}
        """
    try:
        db_cur.execute(query.format(agreement))
        db_obj.commit()
        print("{} row(s) updated".format(db_cur.rowcount))
    except mysql.connector.Error as e:
        print("There was a problem with the query:")
        print("\t{}".format(e))
        print("No updates were made. \nExiting...")
        quit()

if __name__ == '__main__':
    mydb = connect_to_db()
    my_cursor = create_cursor(mydb)
    return_item(mydb, my_cursor)
    my_cursor.close()
    mydb.close()
    print("Database connection closed. Bye!")
