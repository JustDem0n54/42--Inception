#!/bin/bash

mysqld_safe &
sleep 3

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

killall mysqld_safe
wait

exec mysqld_safe