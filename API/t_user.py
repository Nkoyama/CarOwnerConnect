import log

def create_account(cursor, data):
	try:
		sql = '''
				insert into t_user(
					username,
					password,
					delivery_ymd,
					birth_ymd,
					favorite_drive_location
				)
				values(
					"test",
					"test",
					"",
					"",
					"test"
				)
			'''
	
		result = cursor.execute(sql)

		log.write_logs('INSERT t_user' + str(result), sql)
	
		return result

	except Exception as e:
		log.write_logs('EXCEPTION create_account', e)
		raise Exception
