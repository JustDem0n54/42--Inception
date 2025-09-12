FROM debian:12-slim 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
  php-fpm \
  php-mysql \
  mariadb-client \
  wget \
  unzip \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
      && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.3.1-fr_FR.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz


RUN chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY conf/initwordpress.sh  /initwordpress.sh

RUN chmod +x /initwordpress.sh

EXPOSE 9000

ENTRYPOINT ["/initwordpress.sh"]

