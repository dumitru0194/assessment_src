FROM ubuntu:20.04

# Set noninteractive mode and set necessary variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Bucharest 


# Install wget and git
RUN apt-get update && apt-get install -y gnupg lsb-release git wget build-essential libxml2 libxml2-dev nginx lsyncd sudo nano net-tools pkg-config libssl-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev libpng-dev libfreetype6-dev libmcrypt-dev libxslt1-dev

# Copy Nginx configs into container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/nginx-selfsigned.crt /etc/nginx/ssl/
COPY ./nginx/nginx-selfsigned.key /etc/nginx/ssl/
COPY ./nginx/src/index.php /usr/share/nginx/html/

# Copy lsync configuration
COPY ./lsyncd/lsyncd.conf.lua /etc/lsyncd/lsyncd.conf.lua

# Download PHP 5.2.17
RUN wget -P /tmp/ http://museum.php.net/php5/php-5.2.17.tar.bz2

# Extract the downloaded file
RUN cd /tmp && tar -xjf php-5.2.17.tar.bz2

# Change to the extracted directory
WORKDIR /tmp/php-5.2.17

# Download the patch
RUN wget -P /tmp/ https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt

# Apply the patch
RUN patch -p0 < /tmp/txtbgxGXAvz4N.txt

# Configure PHP
RUN ./configure

# Build PHP
RUN make

# Install PHP
RUN make install

# Add MySQL install script repository
RUN cd /tmp/ && git clone https://github.com/dumitru0194/assessment_src.git

# Run the script without sudo
RUN cd /tmp/assessment_src/ && bash -x ./mysql5.7-installation.sh

# Add a user with sudo rights and password "1234"
RUN useradd -m -s /bin/bash -G sudo myuser && echo 'myuser:1234' | chpasswd

# Expose ports for Nginx and MySQL
EXPOSE 80 3306 443

# Start Nginx and MySQL services
CMD service nginx restart && service mysql restart && /bin/bash
