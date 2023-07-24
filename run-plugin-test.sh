#!/bin/bash
set -x

docker exec -t docker-moodle_moodleapp_1 php /var/www/html/admin/tool/phpunit/cli/init.php

#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/model_configuration_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/model_configurations_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/model_version_test.php
docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/model_version_complete_creation_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/evidence_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/dataset_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/dataset_anonymized_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/training_dataset_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/test_dataset_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/model_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/predictions_dataset_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/related_data_test.php
#docker exec -t -w /var/www/html docker-moodle_moodleapp_1 vendor/bin/phpunit admin/tool/laaudit/tests/related_data_anonymized_test.php
