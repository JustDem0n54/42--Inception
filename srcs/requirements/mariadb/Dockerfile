FROM debian:bookworm

RUN apt update && \
    apt install mariadb-server -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
    && chmod 755 /var/lib/mysql

RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/create_db.sh /create_db.sh
RUN chmod +x /create_db.sh

USER mysql

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "create_db.sh"]
