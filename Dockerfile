FROM ubuntu:20.04

# Set noninteractive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install wget and git
RUN apt-get update && apt-get install -y git wget

# Install build essentials and libxml2-dev
RUN apt-get install -y build-essential libxml2 libxml2-dev

# Change to the extracted directory
WORKDIR /tmp

# Download PHP 5.2.17
RUN wget http://museum.php.net/php5/php-5.2.17.tar.bz2

# Extract the downloaded file
RUN tar -xjf php-5.2.17.tar.bz2

# Change to the extracted directory
WORKDIR /tmp/php-5.2.17

# Download the patch
RUN wget https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt

# Apply the patch
RUN patch -p0 < txtbgxGXAvz4N.txt

# Configure PHP
RUN ./configure

# Build PHP
RUN make

# Install PHP
RUN make install

# Install Nginx
RUN apt-get install -y nginx

# Add MySQL install script repository
RUN git clone https://github.com/dumitru0194/gpg-key.git

# Enter to script location Directory
WORKDIR /tmp/gpg-key

# Run the script without sudo
RUN bash -x mysql5.7-installation.sh

# Add a user with sudo rights and password "1234"
RUN useradd -m -s /bin/bash -G sudo myuser && echo 'myuser:1234' | chpasswd

# Expose ports for Nginx and MySQL
EXPOSE 80 3306

# Start Nginx and MySQL services
CMD service nginx start && service mysql start && /bin/bash
