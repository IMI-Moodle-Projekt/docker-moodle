# Docker-Moodle
# Dockerfile for moodle instance. more dockerish version of https://github.com/sergiogomez/docker-moodle
# Forked from Jade Auer's docker version. https://github.com/jda/docker-moodle
# Forked from Jonathan Hardison's version  https://github.com/jmhardison/docker-moodle/pkgs/container/docker-moodle
FROM ubuntu:20.04
LABEL maintainer="Linda Fernsel <lifaythegoblin@mailbox.org>"

VOLUME ["/var/moodledata"]
EXPOSE 80 443
COPY moodle-config.php /var/www/html/config.php

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Database info and other connection information derrived from env variables. See readme.
# Set ENV Variables externally Moodle_URL should be overridden.
ENV MOODLE_URL http://127.0.0.1
#ENV TERM xterm

# Enable when using external SSL reverse proxy
# Default: false
# ENV SSL_PROXY false

COPY ./foreground.sh /etc/apache2/foreground.sh

RUN apt-get update && apt-get upgrade -y && \
apt-get -y install nano \
mysql-client pwgen python-setuptools curl git unzip apache2 php \
php-gd libapache2-mod-php postfix wget supervisor php-pgsql curl libcurl4 \
libcurl3-dev php-curl php-xmlrpc php-intl php-mysql git-core php-xml php-mbstring php-zip php-soap cron php-ldap && \
cd /tmp && \
git clone -b MOODLE_400_STABLE git://git.moodle.org/moodle.git --depth=1 && \
mv /tmp/moodle/* /var/www/html/ && \
rm /var/www/html/index.html

# Add Plugins
ADD ./plugins/certificate.tar.xz /var/www/html/mod/
ADD ./plugins/choicegroup.tar.xz /var/www/html/mod/
ADD ./plugins/mass_enroll.tar.xz /var/www/html/local/

RUN chown -R www-data:www-data /var/www/html && \
chmod +x /etc/apache2/foreground.sh

#cron
COPY moodlecron /etc/cron.d/moodlecron
RUN chmod 0644 /etc/cron.d/moodlecron

# Enable SSL, moodle requires it
RUN a2enmod ssl && a2ensite default-ssl  #if using proxy dont need actually secure connection

# Cleanup, this is ran to reduce the resulting size of the image.
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/cache/* /var/lib/log/* /var/lib/dpkg/*

# Update PHP settings 
RUN sed -i "s/post_max_size.*/post_max_size = 0/" /etc/php/7.4/apache2/php.ini && \
sed -i "s/upload_max_filesize.*/upload_max_filesize = 128M/" /etc/php/7.4/apache2/php.ini && \
sed -i "s/max_execution_time.*/max_execution_time = 300/" /etc/php/7.4/apache2/php.ini

# Install Moodle
# RUN /usr/bin/php /var/www/html/admin/cli/install_database.php --agree-license --fullname="iug-test-7" --shortname="iug-test-7" --adminuser="admin" --adminpass="Admin12_" --adminemail="admin@localhost.de"

ENTRYPOINT ["/etc/apache2/foreground.sh"]
