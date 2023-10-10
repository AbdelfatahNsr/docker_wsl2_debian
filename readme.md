# Customizing Apache Configuration in a Docker Container in Wsl2 Debian

This guide outlines the steps to customize an Apache web server configuration within a Docker container. By creating a custom Docker image with your desired Apache settings, you can run web applications with specific configurations.

## 1. Create a Custom Docker Image

1. Create a directory for your Docker project and navigate to it in the terminal.

2. Create a `Dockerfile` in your project directory. Use a text editor to create a file named `Dockerfile` (without any file extension).

3. Add the following content to your `Dockerfile`:

   ```Dockerfile
   # Use an official Apache base image from Docker Hub
   FROM httpd:2.4

   # Copy your custom Apache configuration into the container
   COPY custom-apache.conf /usr/local/apache2/conf/custom-apache.conf

   # Enable necessary Apache modules if required
   # Example: RUN a2enmod rewrite

   # Start Apache
   CMD ["httpd-foreground"]
   ```

   - Replace `httpd:2.4` with your preferred Apache image from Docker Hub.
   - Adjust the paths and commands according to your needs.

4. Save the `Dockerfile`.

## 2. Create Your Custom Apache Configuration

1. Create a custom Apache configuration file (e.g., `custom-apache.conf`) with the changes you want. For example:

   ```apache
    <VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        DirectoryIndex index.php index.html
        <Directory /var/www/html>
             Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

    </VirtualHost>
   ```

   - Place this `custom-apache.conf` file in the same directory as your `Dockerfile`.

## 3. Build the Docker Image

1. In the terminal, navigate to the directory containing your `Dockerfile` and the custom Apache configuration file.
   ```
   FROM php:8.1-apache
   WORKDIR /var/www/html  # Assuming this is your web root directory
   COPY --chown=www-data:www-data . /var/www/html
   COPY custom-apache.conf /etc/apache2/sites-available/000-default.conf
   CMD ["apache2-foreground"]
   ```

2. Build your custom Docker image using the following command:

   ```bash
   docker build -t api-end .
   ```

   - Replace `api-end` with your preferred image name.

## 4. Run the Docker Container

1. Once the image is built, run a Docker container from it, exposing the necessary ports and potentially mounting your web application files as volumes into the container:

   ```bash
   docker run -d -p 8081:80 --name api-end-container -v $(pwd):/var/www/html api-end
   ```

   - `-d` runs the container in detached mode.
   - `-p 8081:80` maps port 8081 on your host to port 80 in the container.
   - `-v $(pwd):/var/www/html` mounts your web application files into the container.

   - Adjust the ports and volume mapping as needed for your specific setup.

