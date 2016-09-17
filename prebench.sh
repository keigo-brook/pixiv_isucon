#!/bin/bash
set -ex

date_format=$(date "+%Y%m%d_%H%M%S")

if [ -f /var/log/mysql/slow-query.log ]; then
    sudo mv /var/log/mysql/slow-query.log /var/log/mysql/slow-query.log.$date_format
fi

if [ -f /var/log/nginx/isucon-access.log ]; then
    sudo mv /var/log/nginx/isucon-access.log /var/log/nginx/isucon.access.log.$date_format
fi

unicorn_log=/home/isucon/private_isu/webapp/ruby
if [ -f $unicorn_log/stderr.log ]; then
  sudo mv $unicorn_log/stderr.log $unicorn_log/stderr.log.$date_format
else
  sudo touch $unicorn_log/stderr.log; sudo chmod 666 $unicorn_log/stderr.log
fi
if [ -f $unicorn_log/stdout.log ]; then
  sudo mv $unicorn_log/stdout.log $unicorn_log/stdout.log.$date_format
else
  sudo touch $unicorn_log/stdout.log; sudo chmod 666 $unicorn_log/stderr.log
fi

sudo sysctl -p
sudo systemctl daemon-reload
sudo systemctl restart mysql
sudo service memcached restart
sudo systemctl restart isu-ruby
sudo systemctl restart nginx
