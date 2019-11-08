#!/usr/bin/python3

from flask import Flask
import sqlite3

app = Flask(__name__)

@app.route('/')
def hello():
    return '<h1>Hello</h1>'


if __name__ == '__main__':
    with sqlite3.connect('gym.db') as connection:
        connection.execute('DROP TABLE IF EXISTS users')
        connection.execute('CREATE TABLE users (id TEXT, nome TEXT, email TEXT, litros REAL)')
        connection.execute('INSERT INTO users VALUES ("1", "Nuno", "nuno@gmail.com", 0)')
        connection.execute('INSERT INTO users VALUES ("2", "Rui", "rui@gmail.com", 0)')
        connection.commit()

        cursor = connection.cursor()
        cursor.execute('SELECT * FROM users')
        print(cursor.fetchall())

#    app.run()
