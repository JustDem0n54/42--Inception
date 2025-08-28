FROM debian:bookworm

RUN apt update -y && apt install -y wget \ 
	php-fpm \ 
	php-mysql \
	mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.8.2-fr_FR.tar.gz && rm wordpress-6.8.2-fr_FR.tar.gz

RUN chown -R root:root /var/www/wordpress

COPY conf/php.ini /etc/php/8.2/fpm/php.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp_config.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wp_config.sh
ENTRYPOINT [ "/usr/local/bin/wp_config.sh" ]

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]