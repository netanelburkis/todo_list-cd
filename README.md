# ToDo List - CI/CD Infrastructure⚙

This repository contains the configuration files and deployment scripts necessary to set up and manage the CI/CD infrastructure for the ToDo List application in the repository:  
🔗 [ToDo List application repository](https://github.com/netanelburkis/netanelburkis-netanel_bukris_todo_app_repu).

## 🚀 Features
- **Automated Deployment** using Jenkins
- **Pre-configured Scripts** for Nginx, MySQL, and Flask
- **Ansible Automation** for server setup
- **Infrastructure as Code** with Terraform for AWS resources

## 🛠️ Requirements
Before you start, make sure the following tools are installed:
- **Jenkins** (for CI/CD pipeline)
- **Ansible** (for automating server setup)
- **Docker** (optional, for containerized Flask app)
- **MySQL** (for app's database)
- **Gunicorn** (WSGI server for Flask)
- **Nginx** (for reverse proxy)
- **Terraform** (for infrastructure provisioning)

---

## Repository Structure🗂️

### 1. Jenkins✅

- `Jenkinsfile` – Defines the CI/CD pipeline stages:
  - Code testing
  - Build
  - Deploy to Staging and Production
  - Notifications (e.g., Slack / Email)
  - Jenkinsfile-ansible – Deploys the application using Ansible when files in the ansible/ directory change.

### 2. Application Setup (Nginx, MySQL, Flask)🧰

- `user_data/` – Directory containing user data scripts:
  - `user_data_nginx.sh` – Script to install and configure Nginx as a reverse proxy for the Flask app.
  - `user_data_mysql.sh` – Script to install MySQL, create a database, and configure a user for the app.
  - `user_data_app.sh` – Script to start the Flask application (e.g., with Gunicorn), including environment setup and optional Docker usage.

### 3. Version Management📋

- `production_version.txt` – A text file containing the current version (commit hash/tag) deployed in the **Production** environment.
- `stage_version.txt` – A text file with the version currently running in the **Staging** environment.

### 4. Ansible Configuration 🛠️
This repository includes Ansible playbooks that automate the deployment and configuration of servers for the ToDo List application.

Ansible ensures consistent installation and setup of all components like Nginx, MySQL, and the Flask app across environments.

To deploy on staging servers, run:
```bash
ansible-playbook -i inventories/staging_inventory.ini ansible/playbooks/deploy.yml
```

### 5. Terraform Infrastructure & Infrastructure as Code 🏗️
Terraform files provision AWS infrastructure resources needed for the ToDo List app and CI/CD environment.

Includes:

- VPC and networking setup
- EC2 instances for Jenkins agents and app servers
- Application Load Balancer (ALB) for distributing traffic
- Route53 DNS configuration
- Variables defined in vars.tf

**Terraform Components**

- VPC: Custom Virtual Private Cloud for network isolation
- EC2 Instances: Virtual machines for Jenkins agents and the ToDo List app
- Application Load Balancer (ALB): Distributes incoming traffic to EC2 instances
- DNS Configuration: Route53 records for the ALB domain
- Variables Management (vars.tf): Central configuration variables

**How to Use Terraform**
1.Initialize Terraform:
```bash
terraform init
```

2.Review the execution plan:
```bash
terraform plan -var-file="vars.tfvars"
```

3.Apply the configuration:
```bash
terraform apply -var-file="vars.tfvars"
```

4.Destroy the infrastructure (optional):
```bash
terraform destroy -var-file="vars.tfvars"
```

You can use the `-auto-approve` flag to skip the confirmation prompt.

**File	Description**
- main.tf	Defines main AWS resources: VPC, EC2, ALB
- alb.tf	Application Load Balancer configuration
- dns.tf	Route53 DNS records for ALB domain
- ec2.tf	EC2 instance and security groups setup
- vpc.tf	VPC, subnets, internet gateway, route tables
- vars.tf	Variables used throughout Terraform configuration
- outputs.tf	Outputs like ALB DNS name, instance IP addresses

### Jenkins & Ansible Integration

This repository contains two Jenkinsfiles for different deployment strategies:

Jenkinsfile – This file is responsible for deploying the application to Staging and Production environments using Docker. It handles version management through stage_version.txt and production_version.txt files.

Jenkinsfile-ansible – This file deploys the application using Ansible. When there are changes in files within the ansible/ directory, it will run an Ansible playbook to configure and deploy the application on the target servers.

How to use:
If you want to deploy using Docker (via Jenkins), use the Jenkinsfile.

If you need to automate server setup and deployment with Ansible, use the Jenkinsfile-ansible.

Make sure to choose the appropriate Jenkinsfile based on your deployment needs.

⚙️ How to Use Ansible
1. Setup Servers Using Ansible
First, clone this repository to your local machine or server.

Make sure you have an Ansible installation.

Run the following command to configure the servers for staging:
```bash
ansible-playbook -i inventories/staging_inventory.ini ansible/playbooks/deploy.yml
```

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
```bash
bash user_data/user_data_nginx.sh
```
Similarly, you can run the MySQL and Flask app scripts:
```bash
bash user_data/user_data_mysql.sh
bash user_data/user_data_app.sh
```

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

[Jenkins Documentation](https://www.jenkins.io/doc/)

[Ansible Documentation](https://docs.ansible.com/)

[Flask Documentation](https://flask.palletsprojects.com/en/stable/)

[MySQL Documentation](https://dev.mysql.com/doc/)

By following this guide, you should be able to quickly set up and manage the CI/CD infrastructure for your ToDo List application. Feel free to contribute or open issues if you encounter any problems!
