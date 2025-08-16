FROM debian:bookworm

RUN apt update -y && apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/create_db.sh /usr/local/bin
RUN chmod +x /usr/local/bin/create_db.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/create_db.sh" ]
