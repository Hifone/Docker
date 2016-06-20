#!/bin/bash

echo 'start config mysql...'
mysqld_safe &
echo 'sleep 3s for mysql to launch'
sleep 3

service ssh start
service rsyslog start
service nginx start
service php7.0-fpm start
cron