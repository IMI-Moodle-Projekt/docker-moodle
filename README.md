## A local Moodle instance via Docker

Moodle 4.2 with PHP 8.1 and MySQL 8.0.32. Database and Moodle code are external volumes.

### Quick start
* *Start*: 
  * Download the bash script `start.sh` from this repo (or have it sent to you). 
  * Open a terminal and run it: `bash start.sh`. This will clone this repo at the correct branch, including the Moodle and LaLA submodules, start up the docker containers, load test data and start listening to adhoc tasks. 
* *Stop*: `Ctrl` + `C`, then type `docker-compose down`.

### Listening to adhoc tasks (again)
LaLA uses adhoc tasks to run the model version creation in the background. Run `bash run-cron.sh`. This also starts the listening back up if it has ended due to the time limit being reached.

### Not using quick start
* Clone this repo.

* To start (in this repo root): `docker-compose up`
* To stop (in this repo root): `docker-compose down`

* To load test data: `restore-courses.sh`.
* See above for how to start listening to adhoc tasks.

### Set up Moodle
0. If you used the quick start, Moodle is already installed.
1. Optionally: `bash reset.sh`
2. Run `bash install-moodle.sh`
3. Optionally: run `php /var/www/html/admin/cli/cfg.php --name=debug --set=32767` (logs more things)

Admin credentials are:
* *username*: `admin`
* *password*: `Admin12_`

### Use Moodle
Go to `http://localhost:80` and log in with your credentials.

### Modifying the Moodle instance from within the container
To enter the shell of a docker container
`docker exec -it <CONTAINER_ID> /bin/bash`, eg. `docker exec -it b698c1cd3f2e /bin/bash`

### The LaLA plugin
#### Installation
1. If you used the quick start, LaLA is already copied to Moodle. Otherwise, copy the LaLA plugin into `/moodle/admin/tools/`.
2. Check out the homepage of your Moodle instance and run the updates to install the plugin.
1. Go to "Site Administration" > "Analytics settings" and 
 * uncheck "Analytics processes execution via command line only"
 * set Analysis time limit per model to 60 minutes
 * set "Keep analytics calculations for " to "Never delete calculations"

#### Tests
To run plugin tests: `bash run-plugin-test.sh`

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
This is a fork of [Jim Hardison's](https://github.com/jmhardison/docker-moodle/pkgs/container/docker-moodle) Moodle Docker, which is a fork of [Jade Auer's](https://github.com/jda/docker-moodle) Dockerfile, which is a reductionist take on [sergiogomez](https://github.com/sergiogomez/)'s docker-moodle Dockerfile.
