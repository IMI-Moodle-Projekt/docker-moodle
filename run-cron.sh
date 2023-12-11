#!/bin/bash
set -x

docker exec -t --user www-data docker-moodle-moodleapp-1 php /var/www/html/admin/cli/cron.php
