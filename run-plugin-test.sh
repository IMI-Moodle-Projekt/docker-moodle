#!/bin/bash
set -x

docker exec -t docker-moodle_moodleapp_1 php /var/www/html/admin/tool/phpunit/cli/init.php

docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/dataprivacy/tests/metadata_registry_test.php
