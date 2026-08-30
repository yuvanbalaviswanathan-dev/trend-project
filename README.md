GitHub
   |
   | GitHub Webhook
   v
Jenkins
   |
   | Docker Build
   v
Amazon ECR
   |
   v
Amazon EKS
   |
   v
Kubernetes Deployment
   |
   v
Kubernetes Service
   |
   | LoadBalancer
   v
AWS Load Balancer
   |
   v
Trendify Application
🛠️ Technologies Used
React
HTML
CSS
JavaScript
Nginx
Docker
Terraform
AWS EC2
AWS IAM
Amazon ECR
Amazon EKS
Kubernetes
Jenkins
Git
GitHub
GitHub Webhook
📁 Project Structure
trend-project/
│
├── dist/
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── Screenshot/
│   ├── 01-project-folder-and-repository.png
│   ├── 02-application-localhost-3000.png
│   ├── 03-dockerfile.png
│   ├── 04-docker-image-build.png
│   ├── 05-terraform-plan.png
│   ├── 06-terraform-apply-success.png
│   ├── 07-ec2-running-jenkins-port.png
│   ├── 08-jenkins-pipeline-success.png
│   ├── 09-Jenkins Build #5 Console.png
│   ├── 10-live-application-aws-loadbalancer.png
│   ├── 11-github-webhook-success.png
│   ├── 12-eks-cluster-node-ready.png
│   ├── 13-aws-load-balancer-details.png
│   └── 14-dockerhub-repository.png
│
├── Dockerfile
├── nginx.conf
├── main.tf
├── .dockerignore
├── .gitignore
└── README.md
🐳 Docker Containerization

The application is provided as a production-ready dist directory, so no application build process is required.

The Docker image uses Nginx Alpine to serve the application.

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY dist/ /usr/share/nginx/html/

EXPOSE 80

The Docker image was successfully built and tested locally using port 3000 before cloud deployment.

🌐 Nginx SPA Routing

The application uses client-side routing.

The Nginx configuration supports direct navigation and browser refresh for application routes.

location / {
    try_files $uri $uri/ /index.html;
}

The Collection page was tested after refreshing the browser and the SPA routing configuration was successfully verified.

☁️ Terraform Infrastructure

Terraform was used to provision the supporting AWS infrastructure and Jenkins server.

The Terraform configuration includes:

AWS VPC
Internet Gateway
Public Subnet
Route Table
Route Table Association
Jenkins Security Group
IAM Role
IAM Policy Attachments
IAM Instance Profile
Jenkins EC2 Instance
AWS Region
ap-southeast-2
VPC
CIDR: 10.0.0.0/16
Public Subnet
CIDR: 10.0.1.0/24
Availability Zone: ap-southeast-2a
Jenkins EC2
Instance Type: t3.medium
Root Volume: 30 GB gp3

Terraform was executed using:

terraform init
terraform plan
terraform apply

The successful Terraform plan and apply execution are included in the project evidence.

Note: Terraform was used to provision the supporting AWS infrastructure and Jenkins server. The Amazon EKS cluster used for application deployment is an existing EKS environment.

🔧 Jenkins CI/CD Pipeline

Jenkins was configured to automate the application deployment process.

The pipeline flow is:

Checkout
   ↓
Build Docker Image
   ↓
Login to Amazon ECR
   ↓
Push Image to Amazon ECR
   ↓
Configure EKS
   ↓
Deploy to Kubernetes
   ↓
Verify Deployment
Pipeline Stages
Jenkins checks out the latest code from GitHub.
The Docker image is built using the Dockerfile.
Jenkins authenticates with Amazon ECR.
The Docker image is pushed to Amazon ECR.
Jenkins configures access to the EKS cluster.
Kubernetes Deployment and Service files are applied.
Deployment and application availability are verified.

The Jenkins pipeline completed successfully.

📦 Amazon ECR

Amazon ECR is used as the container image registry for the deployment pipeline.

Repository:

trend-app

ECR image:

242627333410.dkr.ecr.ap-southeast-2.amazonaws.com/trend-app:latest
☸️ Amazon EKS and Kubernetes

The application is deployed to an Amazon EKS Kubernetes cluster.

Kubernetes Deployment
Deployment Name: trend-app
Replicas: 1
Container Port: 80

The deployment uses the Amazon ECR image:

242627333410.dkr.ecr.ap-southeast-2.amazonaws.com/trend-app:latest
Kubernetes Service

The application is exposed using a Kubernetes Service of type LoadBalancer.

Service Name: trend-app-service
Protocol: TCP
Port: 80
Target Port: 80

The Kubernetes Deployment and Service were successfully applied and verified.

🐳 Docker Hub

A Docker Hub repository was created for the project.

yuvanbalaviswanathan/trend-app

The Docker image was successfully tagged and pushed to Docker Hub.

🔗 GitHub Webhook Integration

GitHub Webhook integration was configured with Jenkins.

When changes are pushed to the GitHub repository, the webhook can trigger the Jenkins pipeline automatically.

The successful GitHub Webhook integration is included in the project evidence.

🧪 Application Verification
Local Verification

The Dockerized application was tested locally using:

http://localhost:3000
Kubernetes Verification

The following Kubernetes resources were verified:

kubectl get deployment trend-app
kubectl get pods -l app=trend-app
kubectl get svc trend-app-service

The application pod was successfully running.

Production Verification

The application was successfully accessed through the AWS Load Balancer endpoint.

The Collection page was also refreshed directly to verify the SPA routing configuration.

📸 Project Evidence
1. Project Folder and Repository

2. Application Running on Localhost

3. Dockerfile

4. Docker Image Build

5. Terraform Plan

6. Terraform Apply Success

7. EC2 Jenkins Server

8. Jenkins Pipeline Success

9. Jenkins Build Console

10. Live Application Through AWS Load Balancer

11. GitHub Webhook Success

12. EKS Cluster and Node Ready

13. AWS Load Balancer Details

14. Docker Hub Repository

🔄 Complete CI/CD Flow
Developer
    |
    v
GitHub Repository
    |
    | Webhook
    v
Jenkins
    |
    v
Docker Build
    |
    v
Amazon ECR
    |
    v
Amazon EKS
    |
    v
Kubernetes Deployment
    |
    v
Kubernetes LoadBalancer
    |
    v
AWS Load Balancer
    |
    v
Trendify Application
🔐 Version Control

GitHub is used for version control.

The repository contains:

Production application files
Docker configuration
Nginx configuration
Terraform configuration
Kubernetes configuration
Project screenshots
Project documentation

Sensitive and local files such as Terraform state files, environment files and private key files are excluded using .gitignore.

🚀 Setup Instructions
Clone the Repository
git clone https://github.com/yuvanbalaviswanathan-dev/trend-project.git
cd trend-project
Build Docker Image
docker build -t trend-app:latest .
Run Locally
docker run -d -p 3000:80 --name trend-container trend-app:latest

Open:

http://localhost:3000
Terraform
terraform init
terraform plan
terraform apply
Kubernetes
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
Verify Kubernetes Deployment
kubectl get deployment trend-app
kubectl get pods -l app=trend-app
kubectl get svc trend-app-service
🌍 Final Deployment Result

The Trendify application was successfully:

Containerized using Docker.
Served using Nginx.
Configured for SPA routing.
Supported by AWS infrastructure provisioned using Terraform.
Integrated with Jenkins CI/CD.
Published to Amazon ECR.
Deployed to Amazon EKS using Kubernetes.
Exposed through a Kubernetes LoadBalancer.
Verified through the AWS Load Balancer.
Integrated with GitHub Webhook automation.
Published to Docker Hub.
Documented with project deployment evidence.
🔗 Project Links
GitHub Repository

https://github.com/yuvanbalaviswanathan-dev/trend-project

Docker Hub Repository

https://hub.docker.com/r/yuvanbalaviswanathan/trend-app

Live Application

The application is available through the AWS Load Balancer created for the Kubernetes trend-app-service.

📝 Conclusion

This project demonstrates a complete DevOps deployment workflow for a React-based e-commerce application.

The application was containerized using Docker and served using Nginx. Supporting AWS infrastructure and the Jenkins environment were provisioned using Terraform. Jenkins was configured to automate Docker image creation, Amazon ECR publishing and Kubernetes deployment.

The application was successfully deployed to Amazon EKS and exposed through a Kubernetes LoadBalancer. GitHub Webhook integration enabled automated Jenkins pipeline execution when changes were pushed to the repository.

The final application was verified successfully through the AWS Load Balancer endpoint.