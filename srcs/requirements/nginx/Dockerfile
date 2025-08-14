FROM debian:bookworm

RUN apt update
RUN apt install nginx -y

RUN mkdir -p /etc/nginx/tsl
RUN apt install OpenSSL -y
RUN openssl req -x509 -nodes -out /etc/nginx/tsl/inception.crt -keyout /etc/nginx/tsl/inception.key -subj "/C=FR/ST=OCC/L=PERPIGNAN/O=42/OU=42/CN=nrontard.42.fr/UID=nrontard"

RUN mkdir -p /var/run/nginx