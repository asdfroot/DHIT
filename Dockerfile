FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install PHP dan modul yang dibutuhkan
RUN apt-get update && apt-get install -y \
    php-fpm php-pgsql php-cli php-mbstring php-xml php-curl php-gd php-zip curl unzip \
    && apt-get clean

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Salin file konfigurasi composer dulu (untuk caching layer)
COPY composer.json composer.lock ./

# Jalankan install (tanpa --no-dev jika Anda masih butuh Debug Toolbar)
RUN composer install --no-interaction --optimize-autoloader

# Salin seluruh file project
COPY . .

# Atur izin folder agar tidak Error 500
RUN mkdir -p runtime web/assets && chmod -R 777 runtime web/assets

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "web"]
