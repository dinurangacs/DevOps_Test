# DevOps Multi-Cloud Deployment Projects

This repository contains Terraform and Kubernetes code for deploying WordPress and PHP applications across AWS and Azure environments.

---

## Project Tasks

### 1. Deploy WordPress on AWS Infrastructure with Terraform

- Provision AWS resources: VPC, EC2, RDS MySQL database
- Deploy WordPress application on EC2 connected to RDS
- Secure and modular Terraform code with remote backend for state management
- Includes:
  - VPC with public/private subnets
  - Security groups for EC2 and RDS
  - EC2 instance with WordPress installed
  - RDS MySQL database in private subnet

### 2. Deploy WordPress on Kubernetes

- Deploy official WordPress and MySQL containers on Kubernetes cluster
- Include persistent volumes for data persistence

### 3. Deploy PHP Application on AWS Elastic Beanstalk and Azure App Service

- AWS Elastic Beanstalk:
  - Provision environment with load balancing and auto-scaling
  - Use Terraform to manage infrastructure

- Azure App Service:
  - Deploy PHP application Free Tier App Service Plan
  - Enable Application Insights for monitoring 
  - Setup auto-scaling rules using Azure Monitor Autoscale


---

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/dinurangacs/DevOps_Test.git
   cd DevOps_Test
