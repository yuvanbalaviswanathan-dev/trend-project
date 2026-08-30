# Trendify – React E-Commerce Application Deployment

## 📌 Project Overview

This project demonstrates the deployment of a React-based e-commerce application using modern DevOps and cloud technologies.

The application is deployed as a containerized Nginx application on an Amazon EKS cluster and exposed to the internet using a Kubernetes LoadBalancer Service.

The project demonstrates:

- Application deployment
- Docker containerization
- AWS infrastructure provisioning using Terraform
- Amazon EKS
- Kubernetes Deployment and Service
- Amazon ECR
- Jenkins CI/CD
- GitHub Webhook integration
- Nginx SPA routing
- Kubernetes LoadBalancer

---

# 🏗️ Architecture

The deployment flow is:

GitHub
   ↓
Jenkins
   ↓
Docker Build
   ↓
Amazon ECR
   ↓
Amazon EKS
   ↓
Kubernetes Deployment
   ↓
Kubernetes Pod
   ↓
Kubernetes LoadBalancer
   ↓
Trendify Application

---

# 🛠️ Technologies Used

- React
- HTML
- CSS
- JavaScript
- Nginx
- Docker
- Terraform
- AWS
- Amazon ECR
- Amazon EKS
- Kubernetes
- Jenkins
- Git
- GitHub

---

# 📁 Project Structure

```text
trend-project/
│
├── dist/
│   └── Production-ready React application files
│
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── Dockerfile
├── nginx.conf
├── main.tf
├── .dockerignore
├── .gitignore
└── README.md
