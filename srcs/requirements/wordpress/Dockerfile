FROM debian:bookworm

RUN apt update -y && apt install -y wget \ 
	php-fpm \ 
	php-mysql \
	mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.8.2-fr_FR.tar.gz && rm wordpress-6.8.2-fr_FR.tar.gz

RUN chown -R root:root /var/www/wordpress

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]