#!/bin/bash
set -x

cp moodle-config.php ./moodle/config.php

docker exec -t --user www-data docker-moodle-moodleapp-1 php /var/www/html/admin/cli/install_database.php --agree-license --fullname="test-moodle" --shortname="test-moodle" --adminuser="admin" --adminpass="Admin12_" --adminemail="admin@localhost.de"

# Enable analytics via GUI
docker exec -t --user www-data docker-moodle-moodleapp-1 php /var/www/html/admin/cli/cfg.php --component=analytics --name=onlycli --set=0
