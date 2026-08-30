# Trendify – React E-Commerce Application Deployment



## 📌 Project Overview



This project demonstrates the deployment of a React-based e-commerce application using modern DevOps and cloud technologies.



The application is provided as a production-ready `dist` directory. It is containerized using Docker and Nginx and deployed to an Amazon EKS Kubernetes cluster.



The application is exposed to the internet through a Kubernetes LoadBalancer Service.



## 🎯 Project Objectives



\- Deploy the provided React e-commerce application.

\- Containerize the application using Docker.

\- Serve the application using Nginx.

\- Configure SPA routing for browser refresh.

\- Provision supporting AWS infrastructure using Terraform.

\- Configure Jenkins for CI/CD automation.

\- Build and push the Docker image to Amazon ECR.

\- Deploy the application to Amazon EKS using Kubernetes.

\- Expose the application using a Kubernetes LoadBalancer.

\- Configure GitHub Webhook integration with Jenkins.

\- Maintain the project using Git and GitHub.



## 🏗️ Architecture



```text

GitHub

&#x20;  |

&#x20;  | GitHub Webhook

&#x20;  v

Jenkins

&#x20;  |

&#x20;  | Docker Build

&#x20;  v

Amazon ECR

&#x20;  |

&#x20;  v

Amazon EKS

&#x20;  |

&#x20;  v

Kubernetes Deployment

&#x20;  |

&#x20;  v

Kubernetes Service

&#x20;  |

&#x20;  | LoadBalancer

&#x20;  v

AWS Load Balancer

&#x20;  |

&#x20;  v

Trendify Application

