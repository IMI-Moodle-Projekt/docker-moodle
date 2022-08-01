#!/bin/bash

echo "placeholder" > /var/moodledata/placeholder
chown -R www-data:www-data /var/moodledata
chmod 777 /var/moodledata

read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT

#start up cron
/usr/sbin/cron

#install Moodle
/usr/bin/php /var/www/html/admin/cli/install_database.php --agree-license --fullname="iug-test-7" --shortname="iug-test-7" --adminuser="admin" --adminpass="Admin12_" --adminemail="admin@localhost.de"

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
