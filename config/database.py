from sqlalchemy import create_engine
from sqlalchemy.engine import URL

USERNAME = "root"
PASSWORD = "@21Wahal"
HOST = "127.0.0.1"
PORT = 3306
DATABASE = "healthcare_claims"

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=USERNAME,
    password=PASSWORD,
    host=HOST,
    port=PORT,
    database=DATABASE
)

engine = create_engine(connection_url)