## A local Moodle instance via Docker

Moodle 4.2 with PHP 8.1 and MySQL 8.0.32. Database and Moodle code are external volumes.

### Starting and stopping created Moodle instance
* To start (in the repo root): `docker-compose up`
* To stop (in the repo root): `docker-compose down`

The Moodle instance is at `http://localhost:80` but might not be working yet. You need to set up Moodle the first time.

To enter the shell of a docker container
`docker exec -it <CONTAINER_ID> /bin/bash`, eg. `docker exec -it b698c1cd3f2e /bin/bash`

### Set up Moodle
0. Reset all: `bash reset.sh`
1. Get Moodle 4.2: `git clone -b MOODLE_402_STABLE https://github.com/moodle/moodle.git
2. Copy the "moodle-config.php" file into the moodle directory and rename it to "config.php": `cp moodle-config.php /moodle/config.php`
3. Build the mysql and moodle containers: `docker-compose up --build`
4. In a different terminal, run `docker exec -it <CONTAINER_ID> /bin/bash` (e.g. `docker exec -it docker-moodle_moodleapp_1 /bin/bash`) to get into the shell of the Moodle container
5. In the container bash 
 * run `/usr/bin/php /var/www/html/admin/cli/install_database.php --agree-license --fullname="iug-test-<V_NUMBER>" --shortname="iug-test-<V_NUMBER>" --adminuser="admin" --adminpass="Admin12_" --adminemail="admin@localhost.de"` (this installs Moodle)
 * run `php /var/www/html/admin/cli/cfg.php --name=debug --set=32767` (logs more things)

### Use Moodle
Go to `http://localhost:80` and log in with your chosen credentials, eg. Username `admin` and PW `Admin12_`.

### The LaLA plugin
#### Installation
1. Copy the LaLA plugin into `/moodle/admin/tools/`
2. Check out the homepage of your Moodle instance and run the updates to install the plugin.

#### Use
1. Go to "Site Administration" > "Analytics settings" and 
 * uncheck "Analytics processes execution via command line only"
 * set Analysis time limit per model to 60 minutes
 * set "Keep analytics calculations for " to "Never delete calculations"
2. Upload some data: Go to Courses -> Restore course and upload the "Teaching with Moodle" course back up.

#### Tests
To run plugin tests: `bash run-plugin-test.sh`

### Create more test users
Admins can add new users. 
The following scheme is useful:

username: s0000001

first name: first0000001

last name: last0000001

email: s0000001@localhost.de

pw: Student0000001_

### Database 
The MySQL database is at `127.0.0.1:3306`.

You can use **[MySQL Workbench](https://www.mysql.com/products/workbench/)** to export and import data.

You can use **[PyCharm Pro](https://www.jetbrains.com/help/pycharm/mysql.html)** (available via student or teacher license) to inspect the database. 
* In the Database-tab, create a new connection to a MySQL DB
* Enter the address with port and the credentials given in the moodle_variables.env file
* Chose a MySQL driver (you might need to install one)
* Test the connection

To access the db via **container shell**: 
* In the container shell type `mysql -uroot -p` and enter the pw from the env file.
* `use moodle`
* `show tables;`

You can also access **Moodle's XMLDB editor** at "Site Administration" > "Development" > "XMLDB editor".

## Caveats
The following aren't handled, considered, or need work: 
* moodle cronjob (should be called from cron container)
* log handling (stdout?)
* email (does it even send?)

## Credits
This is a fork of [Jim Hardison's](https://github.com/jmhardison/docker-moodle/pkgs/container/docker-moodle) Moodle Docker, which is a fork of [Jade Auer's](https://github.com/jda/docker-moodle) Dockerfile, which is a reductionist take on [sergiogomez](https://github.com/sergiogomez/)'s docker-moodle Dockerfile.
