#!/bin/bash
set -e

# Install MySQL client.
apt update
apt install -y mysql-client

# Execute SQL commands.
mysql -u root -p'secret_root_password' -e"CREATE USER 'replication_user'@'%' IDENTIFIED BY 'bigs3cret';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';
SHOW MASTER STATUS;" > /opt/masterdb/master_status

cat /opt/masterdb/master_status | tail -n 1 | awk '{print $1}' > /opt/masterdb/file_name
cat /opt/masterdb/master_status | tail -n 1 | awk '{print $2}' > /opt/masterdb/file_position
