#!/bin/bash

rm -f proxysql.cnf
mv proxysql_main.cnf proxysql.cnf
docker compose restart
