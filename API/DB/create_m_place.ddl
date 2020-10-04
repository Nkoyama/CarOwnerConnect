create table m_place (
	place_id		int,
	area_cd			int,
	place_name		char(10),
	dba_timestamp	date	default (current_date),
	del_flg			char(1)	default '0'
);
