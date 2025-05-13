# ToDo List - CI/CD Infrastructure

This repository contains the configuration files and deployment scripts necessary to set up and manage the CI/CD infrastructure for the ToDo List application in the repository:  https://github.com/netanelburkis/netanelburkis-netanel_bukris_todo_app_repu.
It supports automated deployment using Jenkins and includes pre-configured scripts for launching servers running Nginx, MySQL, and the Flask-based application.

---

## Repository Structure

### 1. Jenkins

- `Jenkinsfile` – Defines the CI/CD pipeline stages:
  - Code testing
  - Build
  - Deploy to Staging and Production
  - Notifications (e.g., Slack / Email)

### 2. Application Setup (Nginx, MySQL, Flask)

- `user_data/` – Directory containing user data scripts:
  - `user_data_nginx.sh` – Script to install and configure Nginx as a reverse proxy for the Flask app.
  - `user_data_mysql.sh` – Script to install MySQL, create a database, and configure a user for the app.
  - `user_data_app.sh` – Script to start the Flask application (e.g., with Gunicorn), including environment setup and optional Docker usage.

### 3. Version Management

- `production_version.txt` – A text file containing the current version (commit hash/tag) deployed in the **Production** environment.
- `stage_version.txt` – A text file with the version currently running in the **Staging** environment.

---

## How to Use

### Manual Server Deployment

1. Launch a new server (e.g., Ubuntu EC2).
2. Copy and run one of the user data scripts:
   ```bash
   bash user_data/user_data_nginx.sh