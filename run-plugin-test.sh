#!/bin/bash
set -x

docker exec -t docker-moodle_moodleapp_1 php /var/www/html/admin/tool/phpunit/cli/init.php

docker exec -t docker-moodle_moodleapp_1 /var/www/html/vendor/bin/phpunit --filter tool_dataprivacy_metadata_registry_testcase
