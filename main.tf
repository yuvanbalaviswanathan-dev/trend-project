terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_vpc" "trend_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "trend-vpc"
  }
}

resource "aws_internet_gateway" "trend_igw" {
  vpc_id = aws_vpc.trend_vpc.id

  tags = {
    Name = "trend-igw"
  }
}

resource "aws_subnet" "trend_public_subnet" {
  vpc_id                  = aws_vpc.trend_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "trend-public-subnet"
  }
}

resource "aws_route_table" "trend_public_rt" {
  vpc_id = aws_vpc.trend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.trend_igw.id
  }

  tags = {
    Name = "trend-public-route-table"
  }
}

resource "aws_route_table_association" "trend_public_rta" {
  subnet_id      = aws_subnet.trend_public_subnet.id
  route_table_id = aws_route_table.trend_public_rt.id
}

resource "aws_security_group" "jenkins_sg" {
  name        = "trend-jenkins-sg"
  description = "Security group for Jenkins server"
  vpc_id      = aws_vpc.trend_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "trend-jenkins-sg"
  }
}

resource "aws_iam_role" "jenkins_role" {
  name = "trend-jenkins-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "trend-jenkins-role"
  }
}

resource "aws_iam_role_policy_attachment" "jenkins_ec2_full_access" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "jenkins_ecr_power_user" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "jenkins_eks_cluster_policy" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "jenkins_eks_worker_node_policy" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "trend-store-jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_instance" "jenkins_server" {
  ami                    = "ami-09e887124d6ee3bb9"
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.trend_public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = "trend-jenkins-key"
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash

    set -e

    dnf update -y

    dnf install -y java-21-amazon-corretto
    dnf install -y git
    dnf install -y docker
    dnf install -y wget
    dnf install -y unzip

    systemctl enable --now docker

    usermod -aG docker ec2-user

    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2026.key

    dnf install -y jenkins

    systemctl enable jenkins
    systemctl start jenkins

    KUBECTL_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)

    curl -fsSL -o /tmp/kubectl "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"

    install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl

    rm -f /tmp/kubectl

    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"

    unzip -q /tmp/awscliv2.zip -d /tmp

    /tmp/aws/install

    rm -rf /tmp/aws /tmp/awscliv2.zip

    systemctl restart jenkins
  EOF

  tags = {
    Name = "trend-jenkins-server"
  }
}

output "jenkins_instance_id" {
  value = aws_instance.jenkins_server.id
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "jenkins_public_dns" {
  value = aws_instance.jenkins_server.public_dns
}
