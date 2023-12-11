#!/bin/bash
set -x

docker exec -t --user www-data docker-moodle-moodleapp-1 php admin/cli/upgrade.php --non-interactive
