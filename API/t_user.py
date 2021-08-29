import log

def get_login_info(cursor, username):
	try:
		sql = f'''
			select
				username,
				password,
				del_flg
			from
				t_user
			where
				username	=	"{username}"
		'''

		cursor.execute(sql)
		log.write_logs('SELECT t_user', sql)

		loginInfo = cursor.fetchall()
		log.write_logs('SELECT t_user', str(loginInfo))

		return loginInfo
	except Exception as e:
		log.write_logs('EXCEPTION get_login_info', e)
		raise Exception


def create_account(cursor, data):
	try:
		sql = f'''
			insert into t_user(
				username,
				password,
				delivery_ymd,
				birth_ymd,
				favorite_drive_location
			)
			values(
				"{data['username']}",
				"{data['password']}",
				"{data['delivery_ymd'].replace("/", "")}",
				"{data['birth_ymd'].replace("/", "")}",
				"{data['favorite_drive_location']}"
			)
		'''
		log.write_logs('INSERT t_user', sql)
	
		result = cursor.execute(sql)

		log.write_logs('INSERT t_user ' + str(result), sql)
	
		return result

	except Exception as e:
		log.write_logs('EXCEPTION create_account', e)
		raise Exception


def search_user(cursor, data):
	try:
		sql = f'''
			select
				user_id
			,	username
			,	car_model
			from
				t_user
			where
				del_flg					=	false
			and	birth_ymd				=	"20210201"
	--		and	place_id				=	"{data['place']}"
	--		and	classification_number	=	"{data['classification_number']}"
	--		and	color					=	"{data['color']}"
	--		and	hiragana				=	"{data['hiragana']}"
	--		and	number_1				=	"{data['number_1']}"
	--		and	number_2				=	"{data['number_2']}"
		'''
		log.write_logs('SEARCH t_user', sql)
	
		cursor.execute(sql)
		result = cursor.fetchall()

		log.write_logs('SEARCH t_user ' + str(result), sql)
	
		return result

	except Exception as e:
		log.write_logs('EXCEPTION search_user', e)
		raise Exception
