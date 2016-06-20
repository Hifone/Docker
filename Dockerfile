FROM ubuntu:latest

MAINTAINER guanshiliang maxingchi 

# https://hub.docker.com/r/borales/ubuntu/~/dockerfile/

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN apt-get update && apt-get -y install \
    python-software-properties software-properties-common wget curl git nano openssh-server htop

RUN add-apt-repository ppa:nginx/development && curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get update && apt-get install -y nginx nodejs

RUN cd $HOME && wget http://getcomposer.org/composer.phar && chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer && npm install -g bower grunt-cli gulp pm2

RUN chsh -s /bin/bash www-data && \
    chown -R www-data:www-data /var/www

RUN sed -i "s/# server_tokens off;/server_tokens off;/" /etc/nginx/nginx.conf

RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update

# Installing PHP packages
RUN apt-get install -y mysql-client-5.6 \
    php-apcu php7.0-curl php7.0-fpm php7.0-gd php-imagick php7.0-json \
    php7.0-intl php-memcached php7.0-mcrypt php7.0-mysql php-mongodb \
    php-pear php-redis php7.0-xsl php7.0-mbstring php7.0-zip php7.0-xml php7.0-opcache

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
RUN echo "www-data ALL=(ALL) NOPASSWD:/usr/sbin/service php7.0-fpm restart" >> /etc/sudoers
RUN composer global require "fxp/composer-asset-plugin:~1.1.3"

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

RUN ./launch-hifone.sh

WORKDIR /root/

ADD ./run.sh /run.sh