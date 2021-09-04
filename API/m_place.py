def get_m_place(cursor):
	sql = '''
			select
				place_id
			,	place_name
			from
				m_place
			where
				del_flg	=	0
			order by
				area_cd
		'''
	
	cursor.execute(sql)
	placeList = cursor.fetchall()
	return placeList
