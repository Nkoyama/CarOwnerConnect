from flask import Flask, url_for
from flask import request
import MySQLdb

from common import connect_mysql
import log
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

	log.write_logs('GET placeList', '')

	# close
	cur.close
	conn.close

	return placeList


# アカウント作成(受け取ったアカウント情報をDBに登録)
@app.route("/api/createAccount/", methods=["POST"])
def create_account():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# create account
	try:
		receiveData = request.get_data()

		log.write_logs('POST createAccount', receiveData)

		result = t_user.create_account(
					cur,
					receiveData
					)
		if(result == 1):
			conn.commit()
			return "succeeded"
		else:
			conn.rollback()
			log.write_logs('CALLBACK t_user', receiveData)
			return "failed"

		# close
		cur.close
		conn.close

	except Exception as e:
		log.write_logs('EXCEPTION create_account', e)
		# close
		cur.close
		conn.close

		return "failed"
	finally:
		# close
		cur.close
		conn.close

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=False)
