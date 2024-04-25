#!/bin/bash
set -e

# Execute SQL commands.
mysql -u root -p'secret_root_password' -e"CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitor';
GRANT USAGE, REPLICATION CLIENT ON *.* TO 'monitor'@'%';"
