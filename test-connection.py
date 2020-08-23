import pymysql

'''https://pymysql.readthedocs.io/en/latest/modules/connections.html'''
db = pymysql.connect('127.0.0.1', 'root', 'root', 'new_base', 3308)

# with db:
#     cur = db.cursor()
#     cur.execute("SELECT VERSION()")
#
#     version = cur.fetchone()
#
#     print(f"Database version: {version[0]}")

cursor = db.cursor()
# Drop table if it already exist using execute() method.
# cursor.execute("DROP TABLE IF EXISTS PERSON")
# Create table as per requirement
# sql = """CREATE TABLE PERSON (
#    ID INT NOT NULL,
#    FIRST_NAME  CHAR(20) NOT NULL,
#    LAST_NAME  CHAR(20),
#    AGE INT,
#    SEX CHAR(1),
#    PRIMARY KEY (ID) )"""
# cursor.execute(sql)
# disconnect from server


cursor.execute("SELECT VERSION()")
# Fetch all the rows in a list of lists.
results = cursor.fetchall()
print(results)
db.close()