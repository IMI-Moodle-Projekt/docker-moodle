#!/bin/bash
set -x

docker exec -t --user www-data docker-moodle_moodleapp_1 php /var/www/html/admin/cli/adhoc_task.php --execute --keep-alive=5000
