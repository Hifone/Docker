FROM registry.aliyuncs.com/mxc/lemp

# reinstall the mysql-client and mysql-server due to bug in origin image,refer to:http://askubuntu.com/a/489817
RUN apt-get -y purge mysql-client-core-5.6 && \
  apt-get -y autoremove && \
  apt-get -y autoclean && \
  apt-get -y install mysql-client-core-5.5 && \
  apt-get -y install mysql-server

EXPOSE 80

ADD ./hifone.conf /etc/nginx/sites-enabled/hifone.conf
RUN rm /etc/nginx/sites-enabled/default

ADD ./launch.sh /launch-hifone.sh
ADD ./db.sql /db.sql

CMD bash

WORKDIR /root/