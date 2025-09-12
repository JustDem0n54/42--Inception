#!/bin/bash

set -e

echo "Waiting for mariadb"
until mysql -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DATABASE;" >/dev/null 2>&1; do
  sleep 3
done

echo "Mariadb is ready"
cd /var/www/html

if [ -f /var/www/html/wp-config.php ]; then
  echo "wp-config.php already created"
else
  echo "Creating wp-config.php"
  wp config create \
      --dbname=$MYSQL_DATABASE \
      --dbuser=$MYSQL_USER \
      --dbpass=$MYSQL_PASSWORD \
      --dbhost=mariadb \
      --allow-root
fi

if ! wp core is-installed --allow-root; then
  echo "Wordpress installation"
  wp core install \
      --url=https://nrontard.42.fr \
      --title="42-INCEPTION" \
      --admin_user=$WP_ADMIN \
      --admin_password=$WP_ADMIN_PASSWORD \
      --admin_email=$WP_ADMIN_EMAIL \
      --skip-email \
      --allow-root
  echo "Creating user"
  wp user create \
    $WP_USER \
    $WP_USER_EMAIL \
    --role=author \
    --user_pass=$WP_USER_PASSWORD \
    --allow-root
else
  echo "Wordpress already installed."
fi

exec /usr/sbin/php-fpm8.2 -F


