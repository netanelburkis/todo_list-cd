#!/bin/bash

# Update system packages
yum update -y

# Install Java 21 (Amazon Corretto)
yum install -y java-21-amazon-corretto

# Install Docker
yum install -y docker
systemctl enable docker
systemctl start docker

# Add default user to Docker group
usermod -aG docker ec2-user

# Install Docker Compose v2 (CLI plugin)
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
chown root:root /usr/local/lib/docker/cli-plugins/docker-compose

# Install Python 3 and venv support (amazon linux 2 has python3.7 by default)
amazon-linux-extras enable python3.8
yum clean metadata
yum install -y python3 python3-venv

# Add Google Chrome repository
cat <<EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=Google Chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

# Install Google Chrome
yum install -y google-chrome-stable

# Install Ansible
amazon-linux-extras enable ansible2
yum clean metadata
yum install -y ansible
