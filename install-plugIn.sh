#!/bin/bash
set -x

mkdir moodle/mod/dockmod
cp -r "moodle-mod_dockmod/"* "moodle/mod/dockmod"
docker exec -t --user www-data docker-moodle_moodleapp_1 php /var/www/html/admin/cli/upgrade.php --non-interactive
