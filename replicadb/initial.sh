#!/bin/bash
set -e

# Install MySQL client.
apt update
apt install -y mysql-client

# Execute SQL commands.
mysql -u root -p'secret_root_password' -e"CHANGE MASTER TO
  MASTER_HOST='mariadb_master',
  MASTER_USER='replication_user',
  MASTER_PASSWORD='bigs3cret',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='$(cat /opt/masterdb/file_name)',
  MASTER_LOG_POS=$(cat /opt/masterdb/file_position),
  MASTER_CONNECT_RETRY=10;
  START SLAVE;
  SHOW SLAVE STATUS \G"

mysql -u root -p'secret_root_password' -e"set global read_only = 1;"
