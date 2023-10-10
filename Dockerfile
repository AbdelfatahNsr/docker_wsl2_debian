# Use the official PHP 8.1 Apache image as the base image
FROM php:8.1-apache

# Copy your application files into the document root
COPY --chown=www-data:www-data . /var/www/html

# Copy your custom Apache configuration file
COPY custom-apache.conf /etc/apache2/sites-available/000-default.conf

# Enable necessary Apache modules
RUN a2enmod rewrite expires headers deflate

# Change the working directory if needed (not related to Apache configuration)
WORKDIR /var/www/html

# Start Apache
CMD ["apache2-foreground"]
