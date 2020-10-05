import MySQLdb

# 接続する
conn = MySQLdb.connect(
	user='root',
	passwd='CarOwnerConnect1!',
	host='localhost',
	db='car_owner_connect') 

# カーソルを取得する
cur = conn.cursor()

# SQL（データベースを操作するコマンド）を実行する
# userテーブルから、HostとUser列を取り出す
sql = "select * from m_place"
cur.execute(sql)

# 実行結果を取得する
rows = cur.fetchall()

placeList = ""
i = 0
for row in rows:
	if i == 0:
		placeList = placeList + row[2]
	else:
		placeList = placeList + ", " + row[2]
	i = i + 1

print(placeList)

cur.close
conn.close
