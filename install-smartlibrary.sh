#!/bin/bash
set -x

mkdir moodle/local/smartlibrary
cp -r "moodle-local_smartlibrary/"* "moodle/local/smartlibrary"
docker exec -t --user www-data docker-moodle-moodleapp-1 php /var/www/html/admin/cli/upgrade.php --non-interactive

