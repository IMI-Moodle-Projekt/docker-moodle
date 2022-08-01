## A local Moodle instance via Docker
To start (in the repo root): `docker-compose up`

To stop (in the repo root): `docker-compose down`

The Moodle instance is at `http://localhost:80`.

To enter the shell of a docker container
`docker exec -it <CONTAINER_ID> /bin/bash`, eg. `docker exec -it b698c1cd3f2e /bin/bash`

To reset model: `bash reset.sh`

### Set up Moodle
1. Build the mysql and moodle containers with `docker-compose up`
2. Run `docker exec -it <CONTAINER_ID> /bin/bash`
2. In the container bash 
 * run `/usr/bin/php /var/www/html/admin/cli/install_database.php --agree-license --fullname="iug-test-<V_NUMBER>" --shortname="iug-test-<V_NUMBER>" --adminuser="admin" --adminpass="Admin12_" --adminemail="admin@localhost.de"`
 * run `php /var/www/html/admin/cli/cfg.php --name=debug --set=32767`
2. Go to `http://localhost:80`
4. Go to "Site Administration" > "Analytics settings" and 
 * uncheck "Analytics processes execution via command line only"
 * set "Keep analytics calculations for " to "Never delete calculations"
 

### Use Moodle
Go to `http://localhost:80` and log in with your chosen credentials, eg. Username `admin` and PW `Admin12_`.


### Test Course Data
* Create a new and mostly empty course at "My courses" > "Create new course"
* Download a test course from the [HTW Cloud](https://cloud.htw-berlin.de/apps/files/?dir=/SHARED/Fair%20Enough/Lokaler%20Test%20Moodle%20Server%20Backup/Kurse&fileid=127595605) 
* Restore the test course: In the empty course, "Settings symbol on the upper right" > "Course Reuse" > "Restore"

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

### Backups
To back up the **database** (in the repo root): 
* Check which is the next backup tag
* Compress data folder `sudo tar -zcvpf <BACKUP-FILES-PATH>/data-<TAG>.tar.gz data`, eg. `sudo tar -zcvpf ~/Backup/data-000.tar.gz data`
* Upload in the [HTW Cloud](https://cloud.htw-berlin.de/apps/files/?dir=/SHARED/Fair%20Enough/Lokaler%20Test%20Moodle%20Server%20Backup/Datenbank-Backup&fileid=127595545)

To back up a **course**
* Click on the settings icon in the upper right and select "Backup"
* Select all except "IMS Common Cartridge 1.1", especially "include course logs"
* Download the created backup file (.mbz) to your local backup folder
* Upload downloaded course to the [HTW Cloud](https://cloud.htw-berlin.de/apps/files/?dir=/SHARED/Fair%20Enough/Lokaler%20Test%20Moodle%20Server%20Backup/Kurse&fileid=127595605)

--- 

docker-moodle
=============
[![Docker Release](https://github.com/jmhardison/docker-moodle/actions/workflows/docker-release.yml/badge.svg)](https://github.com/jmhardison/docker-moodle/actions/workflows/docker-release.yml)

Cross published at [github.](https://github.com/jmhardison/docker-moodle/pkgs/container/docker-moodle)

A Dockerfile that installs and runs the latest Moodle stable, with external MySQL Database.

`Note: DB Deployment uses version 5 of MySQL. MySQL:Latest is now v8.`

Tags:
* latest - 3.11 stable (OUTDATED! NOW RUNNING MOODLE 4)
* v3.11 - 3.11 stable
* v3.8 - 3.8 stable
* v3.7 - 3.7 stable
* v3.6 - 3.6 stable
* v3.5 - 3.5 stable
* v3.4 - 3.4 stable
* v3.3 - 3.3 stable
* v3.2 - 3.2 stable
* v3.1 - 3.1 stable

## Installation

```
git clone https://github.com/jmhardison/docker-moodle
cd docker-moodle
docker build -t moodle .
```

## Usage

Test Environment

When running locally or for a test deployment, use of localhost is acceptable.

To spawn a new instance of Moodle:

```
docker run -d --name DB -p 3306:3306 -e MYSQL_DATABASE=moodle -e MYSQL_ROOT_PASSWORD=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodle mysql:5
docker run -d -P --name moodle --link DB:DB -e MOODLE_URL=http://localhost:8080 -p 8080:80 jhardison/moodle
```

You can visit the following URL in a browser to get started:

```
http://localhost:8080 
```
or 
```
http://localhost:80
```

### Production Deployment

For a production deployment of moodle, use of a FQDN is advised. This FQDN should be created in DNS for resolution to your host. For example, if your internal DNS is company.com, you could leverage moodle.company.com and have that record resolve to the host running your moodle container. The moodle url would then be, `MOODLE_URL=http://moodle.company.com`
In the following steps, replace MOODLE_URL with your appropriate FQDN.

In some cases when you are using an external SSL reverse proxy, you should enable `SSL_PROXY=true` variable.

* Deploy With Docker
```
docker run -d --name DB -p 3306:3306 -e MYSQL_DATABASE=moodle -e MYSQL_ROOT_PASSWORD=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodle mysql:5
docker run -d -P --name moodle --link DB:DB -e MOODLE_URL=http://moodle.company.com -p 80:80 jhardison/moodle
```

* Deploy with Docker Compose

Pull the latest source from GitHub:
```
git clone https://github.com/jmhardison/docker-moodle.git
```

Update the `moodle_variables.env` file with your information. Please note that we are using v3 compose files, as a stop gap link env variable are manually filled since v3 no longer automatically fills those for use.

Once the environment file is filled in you may bring up the service with:
`docker-compose up -d`



## Caveats
The following aren't handled, considered, or need work: 
* moodle cronjob (should be called from cron container)
* log handling (stdout?)
* email (does it even send?)

## Credits

This is a fork of [Jade Auer's](https://github.com/jda/docker-moodle) Dockerfile.
This is a reductionist take on [sergiogomez](https://github.com/sergiogomez/)'s docker-moodle Dockerfile.
