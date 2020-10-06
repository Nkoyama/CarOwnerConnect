drop table
	m_place;

create table m_place (
	place_id		int			not null	primary key,
	area_cd			int			not null,
	place_name		char(10)	not null,
	dba_timestamp	date		default (current_date),
	del_flg			char(1)		not null	default '0'
);
