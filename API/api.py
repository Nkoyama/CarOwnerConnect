from flask import Flask, url_for
from flask import request
import MySQLdb

from common import connect_mysql
import m_place
import t_user

app = Flask(__name__)

# 本拠地リストとDBから取得しCSV形式で返却
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


# アカウント作成(受け取ったアカウント情報をDBに登録)
@app.route("/api/create_account/", methods=["POST"])
def create_account():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# create account
	try:
		result = t_user.create_account(
					cur,
					request.form["username"],
					request.form["password"],
					request.form["delivery_ymd"],
					request.form["birth_ymd"],
					request.form["favorite_drive_location"]
					)
		if result:
			return "succeeded"
		else:
			return "failed"
	except:
		return "failed"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=False)
