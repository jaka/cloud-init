#!/bin/sh

[ -n "${MYSQL_PORT_3306_TCP_ADDR}" ] && {
  [ -f /www/config/db.php ] &&
    sed -i -r "s/(servername = ')[^']*/\1${MYSQL_PORT_3306_TCP_ADDR}/" /www/config/db.php
}

/root/php-fastcgi
/usr/sbin/nginx -g 'daemon off;'
