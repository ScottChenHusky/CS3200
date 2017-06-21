#!/usr/bin/env python
import pymysql

user_name = raw_input('Enter your user name: ')
user_password = raw_input('Enter your password: ')
import sys

cnx = pymysql.connect(host='127.0.0.1', user=user_name, password=user_password,
             db='starwarsFinal', cursorclass=pymysql.cursors.DictCursor)

cursor = cnx.cursor()
list_of_character = []

cursor.execute('select character_name from characters')
for row in cursor.fetchall():
    list_of_character.append(row['character_name'].encode('utf8'))


flag = 1
while (flag):
    character_name = raw_input('Enter a character name: ')
    if character_name in list_of_character:
        flag = 0
        break
    sys.stdout.write('Can not find this character!!!\n')

args = [character_name]
cursor.callproc('track_character', args)


for row in cursor.fetchall():
    dict = {}
    for key in row:
        dict[key.encode('utf8')] = row[key.encode('utf8')]
    buffer = ''
    for key in dict:
        buffer += str(key)
        buffer += ': '
        buffer += str(dict[key])
        buffer += ', '

    sys.stdout.write(buffer[:(len(buffer) - 2)] + '\n')

sys.stdout.write('Disconnected\n')
cursor.close()


