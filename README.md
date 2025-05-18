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

How to Use Ansible ⚙️
Install Ansible (if not already installed):

```bash
sudo apt install ansible
```
Run the Playbooks:
Ansible playbooks can be used to configure the servers in different environments (e.g., staging, production).

For example, to configure the staging server, run:

```bash
ansible-playbook -i staging_inventory.ini deploy.yml
```
Replace staging_inventory.ini with the appropriate inventory file, and deploy.yml with the playbook you want to run.

Directory Structure:

ansible/ - Contains all Ansible configuration files:

playbooks/ - Contains the main Ansible playbooks (e.g., deploy.yml).

roles/ - Contains Ansible roles for configuring Nginx, MySQL, and the Flask app.

inventories/ - Contains the server inventory files for different environments (e.g., staging_inventory.ini, production_inventory.ini).

Ansible Playbooks 🔧
deploy.yml: Deploys the application on the target server, including Nginx, MySQL, and the Flask application.

nginx -nginx/tasks-role: Configures Nginx as a reverse proxy for the Flask application.

mysql -db/tasks-role: Installs MySQL, creates a database, and configures a user for the application.

flask_app -app/tasks-role: Sets up the Flask application (with Gunicorn) and optionally uses Docker.

By using these Ansible playbooks, you can easily automate the entire deployment and configuration process for all your environments.

---

## How to Use🛠️

### Manual Server Deployment🚀

1. Launch a new server (e.g., Ubuntu EC2).
2. Copy and run one of the user data scripts:
   ```bash
   bash user_data/user_data_nginx.sh
