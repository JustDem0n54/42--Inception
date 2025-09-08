FROM debian:bookworm

RUN apt update && \
    apt install mariadb-server -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld
	
RUN chown -R mysql:mysql /run/mysqld
RUN chmod -R 777 /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/create_db.sh /create_db.sh
RUN chmod +x /create_db.sh

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "create_db.sh"]
