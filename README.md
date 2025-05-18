# ToDo List - CI/CD Infrastructure⚙

This repository contains the configuration files and deployment scripts necessary to set up and manage the CI/CD infrastructure for the ToDo List application in the repository:  
🔗 [ToDo List application repository](https://github.com/netanelburkis/netanelburkis-netanel_bukris_todo_app_repu).

## 🚀 Features
- **Automated Deployment** using Jenkins
- **Pre-configured Scripts** for Nginx, MySQL, and Flask
- **Ansible Automation** for server setup

## 🛠️ Requirements
Before you start, make sure the following tools are installed:
- **Jenkins** (for CI/CD pipeline)
- **Ansible** (for automating server setup)
- **Docker** (optional, for containerized Flask app)
- **MySQL** (for app's database)
- **Gunicorn** (WSGI server for Flask)
- **Nginx** (for reverse proxy)

---

## Repository Structure🗂️

### 1. Jenkins✅

- `Jenkinsfile` – Defines the CI/CD pipeline stages:
  - Code testing
  - Build
  - Deploy to Staging and Production
  - Notifications (e.g., Slack / Email)

### 2. Application Setup (Nginx, MySQL, Flask)🧰

- `user_data/` – Directory containing user data scripts:
  - `user_data_nginx.sh` – Script to install and configure Nginx as a reverse proxy for the Flask app.
  - `user_data_mysql.sh` – Script to install MySQL, create a database, and configure a user for the app.
  - `user_data_app.sh` – Script to start the Flask application (e.g., with Gunicorn), including environment setup and optional Docker usage.

### 3. Version Management📋

- `production_version.txt` – A text file containing the current version (commit hash/tag) deployed in the **Production** environment.
- `stage_version.txt` – A text file with the version currently running in the **Staging** environment.

### 4. Ansible Configuration 🛠️
This repository also includes Ansible playbooks used for automating the deployment and configuration of the servers required for the ToDo List application.

Ansible helps automate the setup of the servers and the configuration of the application environment. It ensures that all components (e.g., Nginx, MySQL, and the Flask app) are installed and configured consistently across all environments.

⚙️ How to Use Ansible
1. Setup Servers Using Ansible
First, clone this repository to your local machine or server.

Make sure you have an Ansible installation.

Run the following command to configure the servers for staging:

bash
Copy
Edit
ansible-playbook -i inventories/staging_inventory.ini ansible/playbooks/deploy.yml
2. Deploying the Application
The deploy.yml playbook will configure the target server with Nginx, MySQL, and the Flask application.

3. Nginx Setup
The role nginx will install and configure Nginx as a reverse proxy for the Flask application.

4. MySQL Setup
The role mysql will install MySQL, create a database, and configure a user for the application.

5. Flask App Setup
The role flask_app will install and configure the Flask app with Gunicorn (and optionally Docker).

🔧 Manual Server Deployment
If you want to manually set up your server:

Launch a new server (e.g., an Ubuntu EC2 instance).

Copy and run one of the user data scripts:

bash
Copy
Edit
bash user_data/user_data_nginx.sh
Similarly, you can run the MySQL and Flask app scripts:

bash
Copy
Edit
bash user_data/user_data_mysql.sh
bash user_data/user_data_app.sh
📚 Troubleshooting
Problem: MySQL connection fails after deployment.

Solution: Check if MySQL is properly configured in user_data_mysql.sh and ensure the correct database and user permissions are set.

Problem: Nginx is not forwarding requests to Flask.

Solution: Ensure that the Nginx config file is correctly pointing to the Flask application (e.g., Gunicorn socket).

🔄 Version Management
The versions of the application deployed in Staging and Production environments are tracked in the following files:

production_version.txt: Contains the current commit hash or version tag in the Production environment.

stage_version.txt: Contains the version currently running in the Staging environment.

📥 Notifications (Jenkins)
Jenkins can notify you upon successful or failed pipeline stages using Slack or Email integrations.

Make sure to configure the appropriate Slack webhook or Email notification in Jenkins.

🔒 Security Considerations
Nginx: Make sure to secure your Nginx server with SSL certificates, using Let's Encrypt or another trusted provider.

MySQL: Use strong passwords for MySQL users and avoid running MySQL as root.

💬 Additional Resources
Jenkins Documentation

Ansible Documentation

Flask Documentation

MySQL Documentation
