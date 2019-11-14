#!/usr/bin/python3

from flask import Flask
import sqlite3

app = Flask(__name__)

# Initialize DB
connection = sqlite3.connect('gym.db');
connection.execute('DROP TABLE IF EXISTS users')
connection.execute('CREATE TABLE users (id TEXT PRIMARY KEY, nome TEXT, email TEXT, litros REAL)')
for i in range(200):
    connection.execute(f'INSERT INTO users VALUES ("{str(i)}", "Nuno", "nuno@gmail.com", 0)')
connection.commit()

@app.route('/')
def hello():
    return '<h1>Hello</h1>'

@app.route('/users', methods = ['GET'])
def list_users():
    connection = sqlite3.connect('gym.db');
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM users')

    users = cursor.fetchall()
    response = '{"data":['
    for user in users:
        response += f'{{"id":"{user[0]}","name":"{user[1]}","email":"{user[2]}","litros":"{user[3]}"}},'
    # Removes last , and finishes json
    response = response[:-1] + ']}'
    return response


if __name__ == '__main__':
    app.run()
