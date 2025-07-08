# ToDo List - CI/CD Infrastructure⚙

This repository contains the configuration files and deployment scripts necessary to set up and manage the CI/CD infrastructure for the ToDo List application in the repository:  
🔗 [ToDo List application repository](https://github.com/netanelburkis/netanelburkis-netanel_bukris_todo_app_repu).
It integrates tools like Jenkins, Ansible, Terraform, Kubernetes, and Helm to automate deployment and infrastructure provisioning.


## 🚀 Features
CI/CD Pipeline with Jenkins

Infrastructure as Code using Terraform (for AWS)

Automated Server Provisioning with Ansible

Container Orchestration with Kubernetes (k8s)

Deployment Packaging using Helm charts

Pre-configured scripts for:

Nginx

MySQL

Flask (with Gunicorn)

Docker support

## 🛠️ Requirements
Make sure the following tools are installed before you begin:

Jenkins

Ansible

Docker

MySQL

Gunicorn

Nginx

Terraform

Kubernetes CLI (kubectl)

Helm

---

## Repository Structure🗂️

### 1. CI/CD with Jenkins ✅
Jenkinsfile – Pipeline stages:
Code Testing
Build
Deploy to Staging/Production
Slack/Email Notifications
Jenkinsfile-ansible – Triggers Ansible-based deployment when changes occur in ansible/

### 2. Application Setup (Nginx, MySQL, Flask)🧰

Located in the user_data/ directory:
user_data_nginx.sh – Nginx reverse proxy setup
user_data_mysql.sh – MySQL installation, DB/user config
user_data_app.sh – Flask app startup with Gunicorn (Docker optional)

### 3. Version Management📋

production_version.txt – Deployed production version (commit/tag)
stage_version.txt – Currently running staging version

### 4. Ansible Configuration 🛠️
Includes playbooks for provisioning:
Nginx
MySQL
Flask App
Run deployment to staging with:
```bash
ansible-playbook -i inventories/staging_inventory.ini ansible/playbooks/deploy.yml
```

### 5. Terraform Infrastructure & Infrastructure as Code 🏗️
Terraform modules for provisioning AWS infrastructure:
VPC & Networking
EC2 Instances
Application Load Balancer (ALB)
Route53 DNS Configuration
Terraform Files:
main.tf, vpc.tf, ec2.tf, alb.tf, dns.tf, outputs.tf
vars.tf & vars.tfvars for variable management
Run Terraform:
```bash
terraform init
terraform plan -var-file="vars.tfvars"
terraform apply -var-file="vars.tfvars"
# Optional:
terraform destroy -var-file="vars.tfvars"
```
You can use the `-auto-approve` flag to skip the confirmation prompt.

### ☸️Kubernetes & Helm Integration

The CI/CD system can deploy the application on a Kubernetes cluster using Helm charts for templated and repeatable deployments.
Helm Chart Structure:
helm/todo-list/
Chart.yaml
values.yaml
templates/ (includes deployment, service, ingress configs)
Deploying to Kubernetes:
```bash
helm upgrade --install todo-list ./helm/todo-list \
  --namespace todo \
  --create-namespace \
  -f helm/todo-list/values.yaml
```
Kubernetes Features:

Container orchestration

Auto-scaling and self-healing

Network isolation and secrets management

### ⚙️Manual Server Deployment (Optional)
If you're not using Ansible or Kubernetes, you can still use the scripts in user_data/ for manual deployment:
```bash
bash user_data/user_data_nginx.sh
bash user_data/user_data_mysql.sh
bash user_data/user_data_app.sh
```

### 🔧Troubleshooting 
MySQL connection fails?

Check user_data_mysql.sh and ensure DB/user permissions are correct.

Nginx doesn't forward to Flask?

Validate the Nginx configuration and that Gunicorn is running.

### 🔄Version Management
Track deployments via:

production_version.txt

stage_version.txt

Used in Jenkins pipelines for version consistency.

### 📥Jenkins Notifications
Configure Slack or Email notifications in Jenkins to stay updated on:

Build success/failure

Deployment completion

### 🔒Security Best Practices
Nginx: Use HTTPS (e.g., Let's Encrypt SSL)

MySQL: Avoid root; use strong credentials

Secrets: Manage with environment variables or Kubernetes Secrets

### 📚 Resources
🔗 [Jenkins Docs](https://www.jenkins.io/doc/)
🔗 [Ansible Docs](https://docs.ansible.com/)
🔗 [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
🔗 [Kubernetes Docs](https://kubernetes.io/docs/)
🔗 [Helm Docs](https://helm.sh/docs/)
🔗 [Flask Docs](https://flask.palletsprojects.com/)
🔗 [MySQL Docs](https://dev.mysql.com/doc/)