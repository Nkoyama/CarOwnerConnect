import MySQLdb

# 接続する
conn = MySQLdb.connect(
	user='root',
	passwd='CarOwnerConnect1!',
	host='localhost',
	db='mysql') 

# カーソルを取得する
cur = conn.cursor()

# SQL（データベースを操作するコマンド）を実行する
# userテーブルから、HostとUser列を取り出す
sql = "select Host, User from user"
cur.execute(sql)

# 実行結果を取得する
rows = cur.fetchall()

# 一行ずつ表示する
for row in rows:
	print(row)

cur.close
conn.close
