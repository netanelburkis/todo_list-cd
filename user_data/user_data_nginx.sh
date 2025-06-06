#!bin/bash

# ⚠️ Use this section of this user data only when provisioning manually.
# Do not use with Ansible/Ansible-jenkinsfile – may cause conflicts.

# Add Docker's official GPG key:
apt-get update -y
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


cat << EOF > /home/ubuntu/nginx.conf
upstream flask_backend {
        server 172.31.18.174:5000;
        server 172.31.17.14:5000;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://flask_backend;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        }
    }
EOF

docker run --restart unless-stopped -d -p 80:80 -v /home/ubuntu/nginx.conf:/etc/nginx/templates/default.conf.template nginx
