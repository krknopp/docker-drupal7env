# from https://www.drupal.org/requirements/php#drupalversions
FROM php:5.6-apache

RUN a2enmod rewrite
RUN a2enmod deflate
RUN a2enmod headers

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev git \
	cron mysql-client ssmtp php5-mongo dnsutils \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install pcntl gd mbstring pdo pdo_mysql zip

WORKDIR /var/www/html

# Set default Environment Variables
ENV APACHE_DOCROOT=/var/www/html/docroot
ENV APACHE_LOG_DIR=/etc/apache2/sites-enabled

#Install drush
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer \
&& ln -s /usr/local/bin/composer /usr/bin/composer

RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush && cd /usr/local/src/drush \
&& git checkout 7.x && cd /usr/local/src/drush && composer install

# Create volumes for external storage
VOLUME ["/var/www/site", “/etc/apache2/sites-enabled”]

# Add Files
ADD apache-start /apache-start
ADD ssmtp.conf /etc/ssmtp/ssmtp.conf
ADD crons.conf /root/crons.conf
ADD site.conf /etc/apache2/sites-enabled/site.conf

#Add cron job
RUN crontab /root/crons.conf

CMD ["/apache-start"]
