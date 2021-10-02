from flask import Flask, url_for
from flask import request
import MySQLdb
import json

from common import connect_mysql
import log
import m_place
import t_user

app = Flask(__name__)

# 本拠地リストを取得し、JSON形式で返却
@app.route("/api/placeList/", methods=["GET"])
def get_placeList():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# get place list
	try:
		rows = m_place.get_m_place(cur)

		# convert to json
		jsonPlaceList = {
			"place_list": rows
		}

		log.write_logs('GET placeList', '')

		return json.dumps(jsonPlaceList)

	except Exception as e:
		log.write_logs('EXCEPTION get_placeList', e)

	finally:
		# close
		cur.close
		conn.close


# ユーザー情報取得を取得し、JSON形式で返却
@app.route("/api/loginInfo/", methods=["POST"])
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
				'password': rows[0][1],
				'del_flg': rows[0][2]
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
			log.write_logs('ROLLBACK t_user', receiveData)
			return "failed"

	except Exception as e:
		log.write_logs('EXCEPTION create_account', e)

		return "failed"

	finally:
		# close
		cur.close
		conn.close


# ユーザ検索
@app.route("/api/searchUser/", methods=["POST"])
def search_user():
	# database connect
	conn = connect_mysql.get_connect()

	# get cursor
	cur = conn.cursor()

	# create account
	try:
		receiveData = json.loads(request.get_data())

		log.write_logs('POST searchUser', receiveData)

		result = t_user.search_user(cur, receiveData)

		# convert to json
		jsonMatchUser = {
			"match_user": result
		}

		log.write_logs('RESULT search_user', jsonMatchUser)
		return jsonMatchUser

	except Exception as e:
		log.write_logs('EXCEPTION search_user', e)

		return "failed"

	finally:
		# close
		cur.close
		conn.close


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=False)
