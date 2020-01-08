FROM debian:buster

# Dependencies

RUN apt-get update && apt-get upgrade && apt-get install -y nginx
RUN apt-get install -y wget php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-mysql
RUN apt-get install -y php-fpm

# Clear Cache

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Working Directory

WORKDIR /Users/nieyraud/Documents/42_projects/ft_server/workdir