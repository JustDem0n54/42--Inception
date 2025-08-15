FROM debian:bookworm

RUN apt update -y && apt install nginx -y

RUN mkdir -p /etc/nginx/ssl && apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=OCC/L=PERPIGNAN/O=42/OU=42/CN=nrontard.42.fr/UID=nrontard"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

# RUN chmod 755 /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]