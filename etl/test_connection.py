import pymysql

try:
    connection = pymysql.connect(
        host="127.0.0.1",
        user="root",
        password="@21Wahal",      # <-- Put your actual password here
        database="healthcare_claims",
        port=3306
    )

    print("Connected Successfully!")

    connection.close()

except Exception as e:
    print(e)