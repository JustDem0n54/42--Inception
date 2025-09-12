FROM debian:12-slim 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/createdb.sh  /createdb.sh
RUN chmod +x /createdb.sh

EXPOSE 3306

ENTRYPOINT ["/createdb.sh"]