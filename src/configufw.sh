#!/bin/bash

# Flush existing rules and set default policies
sudo iptables -F
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# Allow loopback traffic
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Allow SSH, HTTP, HTTPS, MySQL, and SFTP
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT # MySQL
sudo iptables -A INPUT -p tcp --dport 6022 -j ACCEPT # SFTP

# Allow ICMP echo-reply
sudo iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# Save the rules
sudo iptables-save > /etc/iptables/rules.v4

# Show current rules
sudo iptables -L -v
