#!/bin/bash

sleep 10

cd /var/www/wordpress

echo "Launching database"
echo "   -user: $MYSQL_USER"
echo "   -database: $MYSQL_DATABASE"
echo "   -host: $MYSQL_HOST"
echo ""

echo "Setting up Wordpress..."
wp config create \
	--dbname="$MYSQL_DATABASE" \
	--dbuser="$MYSQL_USER" \
	--dbpass="$MYSQL_PASSWORD" \
	--dbhost=mariadb \
	--path=/var/www/wordpress \
	--allow-root

wp core install \
	--url="$DOMAIN_NAME" \
	--title="Inception" \
	--admin_user="$WORDPRESS_ADMIN" \
	--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
	--admin_email="$WORDPRESS_ADMIN_EMAIL" \
	--skip-email \
	--allow-root

wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" \
	--role=author \
	--user_pass="$WORDPRESS_USER_PASSWORD" \
	--allow-root

echo "Wordpress succesfully set up"

echo "Launching Wordpress..."
exec /usr/sbin/php-fpm8.2 -F

