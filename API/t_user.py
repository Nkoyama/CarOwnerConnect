def create_account(cursor, username, password, delivery_ymd, birth_ymd, favorite_drive_location):
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
					${username},
					${password},
					${delivery_ymd},
					${birth_ymd},
					${favorite_drive_loacation}
				)
			'''
	
		cursor.execute(sql)
	
		return true
	except:
		raise Exception
