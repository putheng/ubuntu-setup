#!/usr/bin/env python3.6
import os
import uuid
import sys
#sys.argv[0]

def random_string(string_length=10):
	random = str(uuid.uuid4())
	random = random.replace("-","")
	return random[0:string_length]

dbuser = random_string()
dbname = random_string(15)
userps = random_string(25)

createdb = "mysql -u root -e \"CREATE DATABASE "+ dbname +"\"; "

createlocal = "mysql -u root -e \"CREATE USER '"+ dbuser +"'@'localhost' IDENTIFIED BY '"+ userps +"'\"; "

createremote = "mysql -u root -e \"CREATE USER '"+ dbuser +"'@'%' IDENTIFIED BY '"+ userps +"'\"; "

grantlocal = "mysql -u root -e \"GRANT ALL PRIVILEGES ON "+ dbname +".* TO '"+ dbuser +"'@'localhost'\"; "

grantremote = "mysql -u root -e \"GRANT ALL ON "+  dbname +".* TO '"+ dbuser +"'@'%'\"; "

flush = "mysql -u root -e \"FLUSH PRIVILEGES\"; "

#os.system(createdb)
#os.system(createlocal)
#os.system(createremote)
#os.system(grantlocal)
#os.system(grantremote)
#os.system(flush)

insert = "mysql -u'homestead' -p'secret' -e \"INSERT INTO space.sqlusage (username, password, dbname) VALUES ('"+ sys.argv[1] +"', '"+ sys.argv[2] +"', '"+ sys.argv[3] +"') \"; "

os.system(insert)

#print("MySQL user created." + insert)
print("Databse :   "+  dbname)
print("Username:   "+ dbuser)
print("Password:   "+ userps)

