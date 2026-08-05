import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

connection = psycopg2.connect(
    host=os.getenv("DATABASE_HOST"),
    database=os.getenv("DATABASE_NAME"),
    user=os.getenv("DATABASE_USER"),
    password=os.getenv("DATABASE_PASSWORD"),
    port=os.getenv("DATABASE_PORT")
)

cursor = connection.cursor()

def save_calculation(num1, num2, operation, result):
    query = """
    INSERT INTO calculations (num1, num2, operation, result)
    VALUES (%s, %s, %s, %s)
    """
    cursor.execute(query, (num1, num2, operation, result))
    connection.commit()