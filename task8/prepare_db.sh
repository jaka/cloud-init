#!/bin/sh
USER=admin
PASS=mypass
DB=test
HOST=127.0.0.1
PORT=3306

mysql -u ${USER} -p${PASS} -h${HOST} -P${PORT} -e "CREATE DATABASE ${DB};"
mysql -u ${USER} -p${PASS} -h${HOST} -P${PORT} ${DB} < 3fs_test-1.sql

mysql -u ${USER} -p${PASS} -h${HOST} -P${PORT} -e "GRANT SELECT ON test.* TO demo@'%' IDENTIFIED BY 'demopass'";
