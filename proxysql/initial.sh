#!/bin/bash
set -e

# Execute SQL commands.
mysql -u root -p'secret_root_password' -e"CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;"
