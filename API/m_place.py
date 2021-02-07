def get_m_place(cursor):
	sql = '''
			select
				*
			from
				m_place
			order by
				area_cd
		'''
	
	cursor.execute(sql)
	placeList = cursor.fetchall()
	return placeList
