FROM php:8.1-fpm-alpine

# Sistem bağımlılıklarını yükle
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    zip \
    unzip \
    curl \
    bash \
    git \
    icu-dev \
    zlib-dev \
    libxml2-dev \
    libzip-dev

# GD eklentisini yapılandır ve kur
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mbstring zip intl xml

# Composer yükle
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

RUN composer install --no-dev --optimize-autoloader
