FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update dan install PHP 8.3 serta modul yang dibutuhkan Yii2
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-pgsql \
    php-cli \
    php-mbstring \
    php-xml \
    php-curl \
    php-gd \
    php-zip \
    curl \
    unzip \
    && apt-get clean

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "web"]
#CMD ["tail", "-f", "/dev/null"]
