#!/bin/bash
set -x

docker exec -t docker-moodle_moodleapp_1 php /var/www/html/admin/tool/phpunit/cli/init.php

docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/model_configuration_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/model_configurations_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/model_version_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/model_version_complete_creation_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/evidence_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/dataset_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/dataset_anonymized_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/training_dataset_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/test_dataset_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/model_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/predictions_dataset_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/related_data_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/lala/tests/related_data_anonymized_test.php
