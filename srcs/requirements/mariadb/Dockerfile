FROM debian:bookworm

RUN apt-get update && \
	apt-get upgrade -y && \
    apt-get install mariadb-server -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/create_db.sh /create_db.sh
RUN chmod +x /create_db.sh

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "create_db.sh"]
