FROM debian:bookworm

RUN apt update && \
    apt install -y nginx openssl curl gettext-base && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/private /etc/ssl/certs /etc/nginx/ssl

ARG DOMAIN_NAME

ENV SSL_CERT=/etc/ssl/certs/nginx-selfsigned.crt
ENV SSL_KEY=/etc/ssl/private/nginx-selfsigned.key

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ${SSL_KEY} \
    -out ${SSL_CERT} \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=nrontard.42.fr" && \
    cp ${SSL_KEY} /etc/nginx/ssl/nginx-selfsigned.key && \
    cp ${SSL_CERT} /etc/nginx/ssl/nginx-selfsigned.crt

COPY conf/nginx.conf /etc/nginx/nginx.conf.template

RUN envsubst '${SSL_CERT} ${SSL_KEY}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]