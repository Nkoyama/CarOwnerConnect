import MySQLdb

def get_connect():
	conn = MySQLdb.connect(
		user='root',
		passwd='CarOwnerConnect1!',
		host='localhost',
		db='car_owner_connect')
	return conn
