import log

def get_t_user(cursor, username):
	try:
		sql = '''
				select
					
				from
					t_user
				where
					username = "test"
			'''
	except Exception as e:
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
