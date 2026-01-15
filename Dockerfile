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

# --- TAMBAHKAN BAGIAN INI ---

# 1. Copy file composer dahulu agar caching layer efisien
COPY composer.json composer.lock ./

# 2. Jalankan install vendor
RUN composer install --no-interaction --no-dev --optimize-autoloader

# 3. Copy seluruh file project (termasuk folder web, models, dll)
COPY . .

# 4. Beri izin folder untuk runtime dan assets (cegah Error 500)
RUN mkdir -p runtime web/assets && chmod -R 777 runtime web/assets

# ----------------------------

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "web"]
