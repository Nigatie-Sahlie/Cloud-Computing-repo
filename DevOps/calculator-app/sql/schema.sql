CREATE DATABASE calculator_db;

-- Connect to calculator_db before running the next command

CREATE TABLE calculations(

    id SERIAL PRIMARY KEY,

    num1 NUMERIC,

    num2 NUMERIC,

    operation VARCHAR(10),

    result NUMERIC,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);