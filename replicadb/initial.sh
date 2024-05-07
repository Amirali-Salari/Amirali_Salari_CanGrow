#!/bin/bash
set -e

# Install MySQL client.
apt update
apt install -y mysql-client

# Execute SQL commands.
mysql -u root -p'$MYSQL_ROOT_PASSWORD' -e"CHANGE MASTER TO
  MASTER_HOST='mariadb_master',
  MASTER_USER='$REPLICATION_USER',
  MASTER_PASSWORD='$REPLICATION_PASSWORD',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='$(cat /opt/masterdb/file_name)',
  MASTER_LOG_POS=$(cat /opt/masterdb/file_position),
  MASTER_CONNECT_RETRY=10;
  START SLAVE;
  SHOW SLAVE STATUS \G"

mysql -u root -p'$MYSQL_ROOT_PASSWORD' -e"set global read_only = 1;"
