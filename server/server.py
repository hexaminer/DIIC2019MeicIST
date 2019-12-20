#!/usr/bin/python3

from flask import Flask, request
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)

users = {1: 'António Silva', 2: 'Carlos Cruz'}

# top = [{'name': ze, 'value': 12, 'timestamp': 77889}]
db = {'total_water': 0, 'top': [], 'baths': []}
top = set()
need_update = True

@app.route('/')
def hello():
    return '<h1>Hello</h1>'

@app.route('/users', methods = ['GET'])
def send_users():
    global need_update
    need_update = False
    return db

@app.route('/users/need_update', methods = ['GET'])
def update_needed():
    return {'need_update': need_update}

# id = int
# value = float
@app.route('/reading', methods = ['POST'])
def read():
    global need_update
    need_update = True
    data = request.get_json(force=True)

    name = users[data['id']]
    db['total_water'] += data['value']
    db['baths'].insert(0, {'name': name, 'value': data['value']})
    if name in top: # remove user from top
        for index, user in enumerate(db['top']):
            if user['name'] == name:
                top.remove(db['top'].pop(index)['name'])
                break

    for index, user in enumerate(db['top']):
        if data['value'] < user['value']:
            db['top'].insert(index, {'name': name, 'value': data['value']})
            top.add(name)
            break

    if len(db['top']) == 0 or name not in top and len(db['top']) < 10:
        db['top'].append({'name': name, 'value': data['value']})
        top.add(name)

    print(db)

    return '{"status": OK}'

if __name__ == '__main__':
    app.run()
