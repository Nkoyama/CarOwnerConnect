drop table
	t_user;

create table t_user (
	user_id					int			not null	primary key	AUTO_INCREMENT,
	username				varchar(20)	not null,
	password				varchar(20)	not null,
	delivery_ymd			char(8),
	birth_ymd				char(8),
	favorite_drive_location	varchar(20),
	place_id				int,
	classification_number	char(3),
	color					char(10),
	hiragana				char(2),
	number_1				char(2),
	number_2				char(2),
	car_model				varchar(30),
	car_image				Mediumblob,
	dba_timestamp			date		default (current_date),
	del_flg					char(1)		not null	default '0'
);
