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
    
    return str(cursor.fetchall())


if __name__ == '__main__':
    app.run()
