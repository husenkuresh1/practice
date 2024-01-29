# Build frontend
FROM node:14 as frontend
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


# for php

# get php fpm 8.1 base image
FROM php:8.1-fpm

# Install dependencies
RUN apt-get update -y --fix-missing

RUN apt-get install -y zip
RUN apt-get install -y vim
RUN apt-get install -y unzip
RUN apt-get install -y curl
RUN apt-get install -y libzip-dev
RUN apt-get install -y libonig-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y nginx
RUN apt-get install -y supervisor 

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-install gd

# Set working directory
WORKDIR /var/www

# Remove the default nginx index page
RUN rm -rf /var/www/html

# Copy project directory in container at /var/www
COPY . /var/www

# Copy front end 
COPY --from=frontend /app/public /var/www/public
COPY --from=frontend /app/resources /var/www/resources

# Change ownership of the application directory to www-data
RUN chown -R www-data:www-data /var/www

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf


# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Change current user to www
USER www-data


# install composer dependencies
RUN composer install --optimize-autoloader --no-dev

#generate key
RUN php artisan key:generate
RUN php artisan config:clear
RUN php artisan cache:clear
RUN php artisan config:cache




# Supervisord for run multiple command in unix
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["supervisord"]