## A local Moodle instance via Docker

Moodle 4.2 with PHP 8.1 and MySQL 8.0.32. Database and Moodle code are external volumes.

### Prerequisites
* A unix OS (tested with Ubuntu 22)
* Docker
* Docker Compose (v.2+)

### Setup
* Clone this repo: `git clone git@github.com:IMI-Moodle-Projekt/docker-moodle.git docker-moodle`
* `cd docker-moodle`
* Initialize submodules: `git submodule update --init --recursive`
* Build: `docker compose up --build -d`
* `docker compose down`
* Install Moodle (see blow). Quick install: `bash install-moodle.sh`
* Install Smartlibrary (see blow). Quick install: `bash install-smartlibrary.sh`
* Load test data: `bash restore-courses.sh`

### Install Moodle
1. Optionally: `bash reset.sh`
2. Run `bash install-moodle.sh`
3. Optionally: run `php /var/www/html/admin/cli/cfg.php --name=debug --set=32767` (logs more things)

Admin credentials are:
* *username*: `admin`
* *password*: `Admin12_`

### Use Moodle
Go to `http://localhost:80` and log in with the admin credentials.

### The Smartlibrary plugin
#### Installation
Run `bash install-smartlibrary.sh`

#### Tests
Run `bash run-plugin-test.sh`

### Modifying the Moodle instance from within the container
To enter the shell of a docker container
`docker exec -it <CONTAINER_ID> /bin/bash`, eg. `docker exec -it b698c1cd3f2e /bin/bash`

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

## Credits
This is a fork of [Linda Fernsel's Moodle Learning Analytics](https://gitlab.com/iug-research/moodle-learning-analytics/docker-moodle.git) Moodle Docker, which is a fork of [Jim Hardison's](https://github.com/jmhardison/docker-moodle/pkgs/container/docker-moodle) Moodle Docker, which is a fork of [Jade Auer's](https://github.com/jda/docker-moodle) Dockerfile, which is a reductionist take on [sergiogomez](https://github.com/sergiogomez/)'s docker-moodle Dockerfile.
