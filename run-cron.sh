#!/bin/bash
set -x

docker exec -d --user www-data docker-moodle-moodleapp-1 php /var/www/html/admin/cli/adhoc_task.php --execute --keep-alive=59
