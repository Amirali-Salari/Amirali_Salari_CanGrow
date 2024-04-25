#!/bin/bash

mysql -u admin -padmin -h 127.0.0.1 -P6032 --prompt='ProxySQL Admin> ' -e "
	SELECT * FROM mysql_servers;
	SELECT * from mysql_replication_hostgroups;
	SELECT * from mysql_query_rules;
	INSERT INTO mysql_servers(hostgroup_id,hostname,port) VALUES (1,'mariadb_master',3306);
	INSERT INTO mysql_servers(hostgroup_id,hostname,port) VALUES (2,'mariadb_replica',3306);
	SELECT * FROM mysql_servers;
	UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_username';
	UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_password';
	UPDATE global_variables SET variable_value='2000' WHERE variable_name IN ('mysql-monitor_connect_interval','mysql-monitor_ping_interval','mysql-monitor_read_only_interval');
	SELECT * FROM global_variables WHERE variable_name LIKE 'mysql-monitor_%';
	LOAD MYSQL VARIABLES TO RUNTIME;
	SAVE MYSQL VARIABLES TO DISK;
	LOAD MYSQL SERVERS TO RUNTIME;
	SELECT * FROM mysql_servers;
	SHOW TABLES FROM monitor;
	SELECT * FROM monitor.mysql_server_connect_log ORDER BY time_start_us DESC LIMIT 2;
	SELECT * FROM monitor.mysql_server_ping_log ORDER BY time_start_us DESC LIMIT 2;
	CREATE TABLE mysql_replication_hostgroups\G
	INSERT INTO mysql_replication_hostgroups (writer_hostgroup,reader_hostgroup,comment) VALUES (1,2,'cluster1');
	LOAD MYSQL SERVERS TO RUNTIME;
	SELECT * FROM monitor.mysql_server_read_only_log ORDER BY time_start_us DESC LIMIT 2;
	SELECT * FROM mysql_servers;
	SAVE MYSQL SERVERS TO DISK;
	SAVE MYSQL VARIABLES TO DISK;
	SHOW CREATE TABLE mysql_users\G
	INSERT INTO mysql_users(username,password,default_hostgroup) VALUES ('root','secret_root_password',1);
	INSERT INTO mysql_users(username,password,default_hostgroup) VALUES ('database_user','secret_password',1);
	SELECT * FROM mysql_users;
	LOAD MYSQL USERS TO RUNTIME;
	SAVE MYSQL USERS TO DISK;
	DELETE FROM mysql_query_rules;
	UPDATE mysql_users SET default_hostgroup=1; # by default, all goes to HG1
	LOAD MYSQL USERS TO RUNTIME;
	SAVE MYSQL USERS TO DISK; # if you want this change to be permanent
	INSERT INTO mysql_query_rules (rule_id,active,match_digest,destination_hostgroup,apply)
	VALUES
	(1,1,'^SELECT.*FOR UPDATE$',1,1),
	(2,1,'^SELECT',2,1);
	LOAD MYSQL QUERY RULES TO RUNTIME;
	SAVE MYSQL QUERY RULES TO DISK; # if you want this change to be permanent
"
