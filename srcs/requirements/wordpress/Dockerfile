FROM debian:bookworm

RUN apt update && apt install -y \
						wget \
						curl \
						php8.2 \
						php8.2-fpm \
						php8.2-mysql \
						unzip \
						mariadb-client \
						less && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/php

WORKDIR /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.8.2-fr_FR.tar.gz && rm wordpress-6.8.2-fr_FR.tar.gz && \
	chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp_config.sh /wp_config.sh

RUN chmod +x /wp_config.sh


ENTRYPOINT [ "/wp_config.sh" ]
