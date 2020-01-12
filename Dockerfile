FROM debian:buster

MAINTAINER nieyraud
#########################
#	Dependencies		#
#########################

RUN apt-get upgrade && apt-get update && apt-get install -y nginx
RUN apt-get install -y wget
RUN apt-get install -y php-fpm php-mysql php-mbstring
RUN apt-get install -y mariadb-server
RUN wget -c https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz && \
    tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.4-all-languages /var/www/html/phpmyadmin
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz && \
    tar -xvf latest-fr_FR.tar.gz
RUN mv wordpress /var/www/html/. && \
    chown -R www-data:www-data var/www/html/wordpress/ && \
    chmod -R 755 var/www/html/wordpress/

#########################
#	  COPYING FILES		#
#########################

COPY ./default /etc/nginx/sites-available/.
COPY ./index.nginx-debian.html var/www/html/index.nginx-debian.html
COPY ./wp-config.php var/www/html/wordpress/wp-config.php
COPY ./admin.sql .

#########################
#	Clear Cache			#
#########################

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#########################
# LAUNCHING INSTRUCTION	#
#########################

CMD	service mysql start && \
	mysql -u root < admin.sql && \
	service nginx start && \
	service php7.3-fpm start && \
	bash