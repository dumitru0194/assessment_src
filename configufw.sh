#!/bin/bash

# Activare UFW
ufw enable

# Setare politici implicite
ufw default deny incoming
ufw default allow outgoing

# Permitere trafic necesar
ufw allow ssh
ufw allow http
ufw allow https
ufw allow 3306/tcp  # MySQL
ufw allow 6022/tcp  # SFTP

# Permitere trafic ICMP pentru echo-reply
ufw allow in on eth0 proto icmp type echo-reply

# Activare reguli
ufw --force enable

# Afisare starea UFW
ufw status verbose