#!/bin/bash
set -e

# Install MySQL client.
apt update
apt install -y mysql-client

# Execute SQL commands.
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e"CREATE USER '$REPLICATION_USER'@'%' IDENTIFIED BY '$REPLICATION_PASSWORD';
GRANT REPLICATION SLAVE ON *.* TO '$REPLICATION_USER'@'%';
SHOW MASTER STATUS;" > /opt/masterdb/master_status

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e"set global read_only = 0;"

cat /opt/masterdb/master_status | tail -n 1 | awk '{print $1}' > /opt/masterdb/file_name
cat /opt/masterdb/master_status | tail -n 1 | awk '{print $2}' > /opt/masterdb/file_position
