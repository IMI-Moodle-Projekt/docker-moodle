#!/bin/bash

echo "placeholder" > /var/moodledata/placeholder
chown -R www-data:www-data /var/moodledata
chmod 777 /var/moodledata

read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT

#start up cron
/etc/init.d/cron restart

#composer
cd /var/www/html
composer install

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
