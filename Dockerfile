FROM ubuntu:trusty
MAINTAINER Patrick Oberdorf <patrick@oberdorf.net>

RUN apt-get update && apt-get install -y software-properties-common pwgen
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror3.layerjet.com/mariadb/repo/5.5/ubuntu trusty main'
RUN apt-get update && apt-get install -y mariadb-server

RUN rm -rf /var/lib/mysql/*

RUN sed -i -r 's/bind-address.*$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

ADD create_mariadb_admin_user.sh /create_mariadb_admin_user.sh
ADD run.sh /run.sh
RUN chmod 775 /*.sh

EXPOSE 3306
CMD ["/run.sh"]
