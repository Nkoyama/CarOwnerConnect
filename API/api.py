from flask import Flask, url_for
import MySQLdb

from common import connect_mysql
import m_place

app = Flask(__name__)

@app.route("/api/placeList/", methods=["GET"])
def get_placeList():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# get place list
	rows = m_place.get_m_place(cur)

	# convert to csv
	placeList = ""
	i = 0
	for row in rows:
		if i == 0:
			placeList = placeList + row[2]
		else:
			placeList = placeList + ", " + row[2]
		i = i + 1

	# close
	cur.close
	conn.close

	return placeList

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=False)
