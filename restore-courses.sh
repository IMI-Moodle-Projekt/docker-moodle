#!/bin/bash
set -x

docker cp mbz/. docker-moodle-moodleapp-1:/var/mbz

for filename in mbz/*; do
	echo "Backing up $filename"
	docker exec -t --user www-data docker-moodle-moodleapp-1 php /var/www/html/admin/cli/restore_backup.php --file=/var/${filename} --categoryid=1
done;
