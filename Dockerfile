FROM php:8.1-apache
WORKDIR /var/www/html  # Assuming this is your web root directory
COPY --chown=www-data:www-data . /var/www/html
COPY custom-apache.conf /etc/apache2/sites-available/000-default.conf
CMD ["apache2-foreground"]
