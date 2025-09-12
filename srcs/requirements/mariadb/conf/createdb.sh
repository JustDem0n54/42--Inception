#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

check_mariadb_initialized() {
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW TABLES;" &>/dev/null
}

if [ -d "$DATADIR/mysql" ] && check_mariadb_initialized(); then
  echo "MariaDB already created"
  
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

  echo "Start new mariadb with password and network"
  mysqld_safe --datadir="$MYSQL_DATA_DIR" --skip-grant-tables &
  
else

  echo "Mariadb initialisation"
  mysql_install_db --user=mysql --datadir="$DATADIR"

  echo "Start mariadb without network"
  mysqld_safe --skip-networking &
  pid=$!

  echo "Waiting for mariadb to be ready"
  until mysqladmin ping --silent; do
    sleep 1
  done

  echo "Database initialisation"
  mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL

  echo "Stop mariadb"
  mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
  wait $pid

  echo "Start new mariadb with password and network"
  exec mysqld_safe --datadir="$DATADIR" --skip-name-resolve
fi