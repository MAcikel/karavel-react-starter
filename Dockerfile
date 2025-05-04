# PHP 8.1 FPM tabanlı imaj
FROM php:8.1-fpm-alpine

# Gerekli PHP eklentilerini yükle
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql

# Composer'ı yükle
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Çalışma dizini
WORKDIR /var/www

# Uygulama dosyalarını kopyala
COPY . .

# Composer bağımlılıklarını yükle
RUN composer install --no-dev --optimize-autoloader

# Laravel anahtarını oluştur
RUN php artisan key:generate --ansi
