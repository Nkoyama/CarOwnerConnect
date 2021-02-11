import datetime

def write_logs(kind, message):
	now = datetime.datetime.now()
	log_name = "./log/" + str(now.year) + "-" + str(now.month).zfill(2) + "-" + str(now.day).zfill(2) + ".log"
	message = str(message).replace('\n', ' ')
	message = message.replace('\t', ' ')

	f = open(log_name, 'a')
	f.write(str(now))
	f.write('\t')
	f.write(str(kind))
	f.write('\t')
	f.write(str(message) + '\n')
	f.close()
