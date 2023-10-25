#!/bin/bash
set -x

cp moodle-config.php /moodle/config.php

docker-compose up --build

docker exec -t --user www-data docker-moodle_moodleapp_1 php /var/www/html/admin/cli/install_database.php --agree-license --fullname="test-moodle" --shortname="test-moodle" --adminuser="admin" --adminpass="Admin12_" --adminemail="admin@localhost.de"
