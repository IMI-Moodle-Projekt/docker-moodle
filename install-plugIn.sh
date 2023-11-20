#!/bin/bash
set -x

mkdir moodle/admin/tool/lala/
cp -r "moodle-tool_lala/"* "moodle/admin/tool/lala/"
docker exec -t --user www-data docker-moodle_moodleapp_1 php /var/www/html/admin/cli/upgrade.php --non-interactive
