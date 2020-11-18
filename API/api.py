from flask import Flask, url_for
import MySQLdb
app = Flask(__name__)

@app.route("/api/placeList/", methods=["GET"])
def get_placeList():
	#database connect
	conn = MySQLdb.connect(
		user='root',
		passwd='CarOwnerConnect1!',
		host='localhost',
		db='car_owner_connect')
	#get cursor
	cur = conn.cursor()
	#sql
	sql	= '''
			select
				*
			from
				m_place
			order by
				area_cd
		'''
	cur.execute(sql)
	rows = cur.fetchall()

	placeList = ""
	i = 0
	for row in rows:
		if i == 0:
			placeList = placeList + row[2]
		else:
			placeList = placeList + ", " + row[2]
		i = i + 1

	#close
	cur.close
	conn.close

	return placeList

if __name__ == "__main__":
    app.run(port=80, debug=True)
