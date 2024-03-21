FROM ubuntu:20.04

# Set noninteractive mode and set necessary variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Bucharest 


# Install wget and git
RUN apt-get update && apt-get install -y sssd ufw iptables openssh-server curl gnupg lsb-release git wget locate build-essential libxml2 libxml2-dev nginx lsyncd rsync sudo nano net-tools pkg-config

# Copy ssh configs
COPY ./ssh/sshd_config /etc/ssh/sshd_config

# Copy Nginx configs into container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/nginx-selfsigned.crt /etc/nginx/ssl/
COPY ./nginx/nginx-selfsigned.key /etc/nginx/ssl/
COPY ./nginx/src/index.php /usr/share/nginx/html/
RUN rm -f /usr/share/nginx/html/index.html

# Copy lsync configuration
COPY ./lsyncd/lsyncd.conf.lua /etc/lsyncd/lsyncd.conf.lua

# Create directories for lsycn syncronization
RUN mkdir -p /data/www/ /data1/www/ && chmod 755 /data/www && chown root:root /data/www

# Create log and status files for lsync
RUN mkdir -p /var/log/lsyncd/ && touch /var/log/lsyncd/lsyncd.log /var/log/lsyncd/lsyncd.status && lsyncd /etc/lsyncd/lsyncd.conf.lua

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
RUN ./configure --enable-cgi --enable-fastcgi --with-config-file-path=/usr/local/bin/php-config

# Build PHP
RUN make

# Install PHP
RUN make install

# Add MySQL install script repository
RUN cd /tmp/ && git clone https://github.com/dumitru0194/assessment_src.git

# Run the script without sudo
RUN cd /tmp/assessment_src/ && bash -x ./mysql5.7-installation.sh

# Add a user with sudo rights and password "1234"
RUN sudo useradd -m -s /bin/bash -G sudo myuser && echo 'myuser:1234' | sudo chpasswd && echo 'myuser ALL=(ALL:ALL) ALL' | sudo tee -a /etc/sudoers && echo 'myuser ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers


# Expose ports for Nginx and MySQL
EXPOSE 80 3306 443 22 6022 

# Start Nginx, MySQL, Lsyncd, php-cgi
CMD bash -x /tmp/assessment_src/configufw.sh && service ssh start && service lsyncd restart && service nginx restart && service mysql restart && /usr/local/bin/php-cgi -b 127.0.0.1:9000 & /bin/bash
