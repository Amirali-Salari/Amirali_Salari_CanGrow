#!/bin/bash
set -e

# Execute SQL commands.
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e"CREATE USER '$MONITOR_USER'@'%' IDENTIFIED BY '$MONITOR_PASSWORD';
GRANT USAGE, REPLICATION CLIENT ON *.* TO '$MONITOR_USER'@'%';"
