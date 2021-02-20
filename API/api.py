from flask import Flask, url_for
from flask import request
import MySQLdb
import json

from common import connect_mysql
import log
import m_place
import t_user

app = Flask(__name__)

# 本拠地リストを取得し、CSV形式で返却
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


# ユーザー情報取得を取得し、JSON形式で返却
@app.route("/api/loginInfo/", methods=["GET"])
def get_loginInfo():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# get login informations
	try:
		receiveData = json.loads(request.get_data())
		username = receiveData['username']

		log.write_logs('GET get_loginInfo', 'username: ' + str(username))

		rows = t_user.get_login_info(cur, username)
		log.write_logs('get_loginInfo', str(rows))

		# username exists
		if rows and len(rows)>0:
			loginInfo = {
				'username': username,
				'password': rows[1][2],
				'del_flg': rows[1][3]
			}
		# username doesn't exist
		else:
			loginInfo = {
				'username': '',
				'password': '',
				'del_flg': ''
			}
	
		return json.dumps(loginInfo)

	except Exception as e:
		log.write_logs('EXCEPTION get_loginInfo', e)
		# close
		cur.close
		conn.close

	finally:
		# close
		cur.close
		conn.close


# アカウント作成(受け取ったアカウント情報をDBに登録)
@app.route("/api/createAccount/", methods=["POST"])
def create_account():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# create account
	try:
		receiveData = json.loads(request.get_data())

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
