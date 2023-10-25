# Docker-Moodle
# Dockerfile for moodle instance. more dockerish version of https://github.com/sergiogomez/docker-moodle
# Forked from Jade Auer's docker version. https://github.com/jda/docker-moodle
# Forked from Jonathan Hardison's version  https://github.com/jmhardison/docker-moodle/pkgs/container/docker-moodle
FROM ubuntu:22.04
LABEL maintainer="Linda Fernsel <fernsel@htw-berlin.de>"

VOLUME ["/var/moodledata"]
EXPOSE 80 443

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
mysql-client pwgen python-setuptools curl git unzip apache2 php locales \
php-gd libapache2-mod-php postfix wget supervisor php-pgsql curl libcurl4 \
libcurl3-dev php-curl php-xmlrpc php-intl php-mysql git-core php-xml php-mbstring php-zip php-soap cron php-ldap php-cli

# Install composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && \
HASH=`curl -sS https://composer.github.io/installer.sig` && \
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer 

COPY ./moodle-config.php /var/www/html/config.php # Need to copy this by hand since Moodle is a volume!

# Copy plugin into correct folder
COPY moodle-tool_lala/ /var/www/html/admin/tool/lala

RUN chown -R www-data:www-data /var/www/html && \
chmod +x /etc/apache2/foreground.sh

#cron
COPY moodlecron /etc/cron.d/moodlecron
RUN chmod 0644 /etc/cron.d/moodlecron
RUN crontab -u www-data /etc/cron.d/moodlecron

# Enable SSL, moodle requires it
RUN a2enmod ssl && a2ensite default-ssl  #if using proxy dont need actually secure connection

# Cleanup, this is ran to reduce the resulting size of the image.
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/cache/* /var/lib/log/* /var/lib/dpkg/*

# Update PHP settings 
RUN sed -i "s/post_max_size.*/post_max_size = 0/" /etc/php/8.1/apache2/php.ini && \
sed -i "s/upload_max_filesize.*/upload_max_filesize = 128M/" /etc/php/8.1/apache2/php.ini && \
sed -i "s/max_execution_time.*/max_execution_time = 300/" /etc/php/8.1/apache2/php.ini && \
sed -i "s/;max_input_vars.*/max_input_vars = 5000/" /etc/php/8.1/apache2/php.ini

# At the other location as well, just to be sure.
RUN sed -i "s/post_max_size.*/post_max_size = 0/" /etc/php/8.1/cli/php.ini && \
sed -i "s/upload_max_filesize.*/upload_max_filesize = 128M/" /etc/php/8.1/cli/php.ini && \
sed -i "s/max_execution_time.*/max_execution_time = 300/" /etc/php/8.1/cli/php.ini && \
sed -i "s/;max_input_vars.*/max_input_vars = 5000/" /etc/php/8.1/cli/php.ini


# Required for Unit Testing
RUN locale-gen en_AU.UTF-8

ENTRYPOINT ["/etc/apache2/foreground.sh"]
