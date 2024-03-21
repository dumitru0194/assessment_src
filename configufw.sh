#!/bin/bash

# Enable UFW
sudo ufw enable

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow necessary traffic
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp  # MySQL
sudo ufw allow 6022/tcp  # SFTP

# Allow ICMP traffic for echo-reply
sudo ufw allow in on eth0 proto icmp type echo-reply

# Force enable rules
sudo ufw --force enable

# Show UFW status
sudo ufw status verbose
