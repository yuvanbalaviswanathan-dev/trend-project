# Trendify – React E-Commerce Application Deployment

## 📌 Project Overview

This project demonstrates the deployment, automation, and monitoring of a React-based e-commerce application using modern DevOps and cloud technologies.

The Trendify application is containerized using Docker and served using Nginx. It is deployed to an Amazon EKS Kubernetes cluster and exposed to the internet through a Kubernetes LoadBalancer Service.

The project also implements Jenkins CI/CD with GitHub Webhook integration, Amazon ECR for container image storage, and an open-source monitoring stack using Prometheus, Grafana, Node Exporter, and kube-state-metrics.

---

## 🎯 Project Objectives

- Deploy the Trendify React e-commerce application on AWS.
- Containerize the application using Docker and serve it using Nginx.
- Provision AWS infrastructure using Terraform.
- Configure Jenkins for automated CI/CD.
- Build and push the Docker image to Amazon ECR.
- Deploy the application to Amazon EKS using Kubernetes.
- Expose the application using a Kubernetes LoadBalancer Service.
- Integrate GitHub Webhook with Jenkins for automated pipeline triggering.
- Implement open-source monitoring using Prometheus and Grafana.
- Monitor system resources using Node Exporter.
- Monitor Kubernetes resources using kube-state-metrics.
- Verify application availability and monitoring dashboards.

---

## 🏗️ Architecture

```text
                         GitHub
                           |
                    GitHub Webhook
                           |
                           v
                        Jenkins
                           |
                    Docker Build
                           |
                           v
                    Amazon ECR
                           |
                           v
                       Amazon EKS
                           |
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


              Open-Source Monitoring
                           |
          +----------------+----------------+
          |                |                |
          v                v                v
     Prometheus         Grafana       Node Exporter
          |
          |
          v
   kube-state-metrics
```

---

## ☁️ AWS Infrastructure

AWS infrastructure was provisioned using Terraform.

The infrastructure includes:

- Amazon VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 instance
- Jenkins server
- Amazon EKS cluster
- AWS Load Balancer

Terraform was used to define and provision the required AWS resources in a repeatable infrastructure-as-code approach.

---

## 🐳 Docker Containerization

The Trendify production build is available in the `dist` directory.

The application is containerized using Docker and served using Nginx.

The Docker image is built from the project using the Dockerfile and the resulting image is pushed to Amazon ECR for deployment.

Example Docker workflow:

```bash
docker build -t trend-store:v1 .
docker run -d -p 3000:80 --name trend-store-container trend-store:v1
```

The application was verified locally before deploying it to AWS.

---

## ☸️ Kubernetes Deployment

The application is deployed to Amazon EKS using Kubernetes.

The Kubernetes configuration contains the application Deployment and Service definitions.

The application pod was verified using:

```bash
kubectl get pods -A
```

The Trendify application pod was confirmed to be in the `Running` state.

The application is exposed through a Kubernetes LoadBalancer Service.

---

## 🌐 Application Service Verification

The Kubernetes services were verified using:

```bash
kubectl get svc -A
```

The Trendify application service is configured as:

```text
trend-app-service
Type: LoadBalancer
```

The LoadBalancer provides an AWS Load Balancer endpoint for accessing the deployed Trendify application from the internet.

---

## 🔄 Jenkins CI/CD Pipeline

Jenkins is used to automate the application delivery process.

The CI/CD pipeline performs the following stages:

1. Checkout source code from GitHub.
2. Build the Docker image.
3. Push the Docker image to Amazon ECR.
4. Deploy the application to Amazon EKS.
5. Verify the Kubernetes deployment.

The Jenkins pipeline was successfully executed and the build was verified through the Jenkins console.

---

## 🔗 GitHub Webhook Integration

GitHub Webhook integration was configured with Jenkins to automate pipeline execution.

When changes are pushed to the GitHub repository, the webhook triggers the Jenkins pipeline.

This provides an automated CI/CD workflow from source code changes to application deployment.

---

## 📊 Open-Source Monitoring

The Trendify application and Kubernetes infrastructure are monitored using an open-source monitoring stack deployed in the `monitoring` namespace.

The monitoring stack includes:

- Prometheus
- Grafana
- Alertmanager
- Node Exporter
- kube-state-metrics
- Prometheus Operator

---

## 🔍 Prometheus

Prometheus is used to collect and store time-series metrics from the Kubernetes cluster and monitored workloads.

Prometheus was configured as the monitoring data source for Grafana.

The Prometheus service was verified successfully inside the Kubernetes monitoring namespace.

---

## 📈 Grafana

Grafana is connected to Prometheus as the monitoring data source.

A Grafana monitoring dashboard was created to visualize system resource metrics.

The dashboard displays:

- CPU Usage
- Memory Usage
- Disk Usage

The Grafana dashboard was successfully verified using live Prometheus metrics.

---

## 🖥️ Node Exporter

Node Exporter collects system-level metrics from the monitored node.

The collected metrics include:

- CPU utilization
- Memory utilization
- Filesystem usage
- Disk-related metrics
- Host resource information

Node Exporter metrics are collected by Prometheus and visualized through Grafana.

---

## ☸️ kube-state-metrics

kube-state-metrics exposes Kubernetes object-level metrics.

These metrics provide information about Kubernetes resources such as:

- Pods
- Deployments
- ReplicaSets
- Services
- Kubernetes workload states

The metrics are collected by Prometheus and can be visualized through Grafana.

---

## 📦 Monitoring Namespace

The monitoring components are deployed in the Kubernetes `monitoring` namespace.

The monitoring namespace contains the Prometheus and Grafana monitoring stack along with the required exporters and monitoring components.

The monitoring components were verified using:

```bash
kubectl get pods -A
```

The following monitoring components were confirmed to be running:

```text
Prometheus
Grafana
Node Exporter
kube-state-metrics
Alertmanager
Prometheus Operator
```

---

## 🔎 Monitoring Verification

The monitoring setup was verified successfully on the Amazon EKS cluster.

The Kubernetes monitoring pods were confirmed to be running successfully.

Example verification command:

```bash
kubectl get pods -A
```

The monitoring services were also verified using:

```bash
kubectl get svc -A
```

The Grafana dashboard was verified with Prometheus metrics for:

- CPU utilization
- Memory utilization
- Disk utilization

---

## 🛍️ Application Output

The Trendify e-commerce application was successfully deployed and accessed through the AWS LoadBalancer endpoint.

The application output was verified in a web browser after deployment to Amazon EKS.

The deployed application provides the Trendify e-commerce user interface and product collection.

---

## 📸 Project Screenshots

The `Screenshot` directory contains evidence of the project implementation and verification.

### Application

- `01-project-folder-and-repository.png` – Project repository and files
- `02-application-localhost-3000.png` – Local application output
- `21-TREND APP Home page.png` – Trendify application home page
- `22-TREND APP COLLECTION page.png` – Trendify product collection page
- `10-live-application-aws-loadbalancer.png` – Live application through AWS LoadBalancer

### Docker

- `03-dockerfile.png` – Dockerfile configuration
- `04-docker-image-build.png` – Docker image build
- `14-dockerhub-repository.png` – Docker image repository

### Terraform and AWS

- `05-terraform-plan.png` – Terraform plan
- `06-terraform-apply-success.png` – Successful Terraform deployment
- `07-ec2-running-jenkins-port.png` – Jenkins running on EC2
- `13-aws-load-balancer-details.png` – AWS LoadBalancer details

### Jenkins and CI/CD

- `08-jenkins-pipeline-success.png` – Successful Jenkins pipeline
- `09-Jenkins Build #5 Console.png` – Jenkins build console
- `11-github-webhook-success.png` – GitHub Webhook configuration and verification

### Kubernetes / EKS

- `12-eks-cluster-node-ready.png` – EKS cluster and node verification

### Monitoring

- `15-grafana-prometheus-datasource-success.png` – Prometheus datasource successfully configured in Grafana
- `16-grafana-new-dashboard.png` – Grafana dashboard creation
- `17-grafana-node-exporter-up.png` – Node Exporter monitoring
- `18-grafana-cpu-usage.png` – CPU usage monitoring
- `19-grafana-memory-usage.png` – Memory usage monitoring
- `20-grafana-monitoring-dashboard.png` – Grafana monitoring dashboard

---

## 🔍 Monitoring Stack Verification

The following command was used to verify the monitoring components:

```bash
kubectl get pods -A
```

Example monitoring components observed in the cluster:

```text
monitoring
├── Prometheus
├── Grafana
├── Alertmanager
├── Node Exporter
├── kube-state-metrics
└── Prometheus Operator
```

The monitoring components were confirmed to be running successfully in the Amazon EKS cluster.

---

## 🧰 Technologies Used

| Category | Technology |
|---|---|
| Frontend | React |
| Web Server | Nginx |
| Containerization | Docker |
| Infrastructure as Code | Terraform |
| Cloud Platform | AWS |
| Container Registry | Amazon ECR |
| Kubernetes | Amazon EKS |
| CI/CD | Jenkins |
| Version Control | Git |
| Repository | GitHub |
| Webhook | GitHub Webhook |
| Monitoring | Prometheus |
| Visualization | Grafana |
| System Metrics | Node Exporter |
| Kubernetes Metrics | kube-state-metrics |

---

## ✅ Project Verification

The following components were successfully implemented and verified:

- ✅ React e-commerce application deployed
- ✅ Docker containerization completed
- ✅ Nginx configured to serve the application
- ✅ AWS infrastructure provisioned using Terraform
- ✅ Jenkins configured for CI/CD
- ✅ Docker image pushed to Amazon ECR
- ✅ Amazon EKS cluster configured
- ✅ Kubernetes Deployment completed
- ✅ Kubernetes LoadBalancer Service configured
- ✅ GitHub Webhook integration configured
- ✅ Prometheus monitoring configured
- ✅ Grafana dashboard configured
- ✅ Node Exporter configured
- ✅ kube-state-metrics configured
- ✅ Monitoring namespace verified
- ✅ Application output verified
- ✅ Monitoring dashboard verified

---

## 📌 Conclusion

The Trendify React e-commerce application was successfully containerized, automated, deployed, and monitored using AWS and modern DevOps tools.

The complete workflow demonstrates:

```text
GitHub
   ↓
Jenkins
   ↓
Docker
   ↓
Amazon ECR
   ↓
Amazon EKS
   ↓
Kubernetes
   ↓
AWS LoadBalancer
   ↓
Trendify Application
   ↓
Prometheus + Grafana Monitoring
```

This project demonstrates an end-to-end DevOps workflow including infrastructure provisioning, containerization, CI/CD automation, Kubernetes deployment, cloud load balancing, and open-source monitoring.
