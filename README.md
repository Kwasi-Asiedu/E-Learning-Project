# Production Project: E-Learning Platform

## Objective
This project aims to use Amazon's Elastic Container Service (ECS) to build a highly available and scalable e-learning platform. The goal is to leverage government programs to retrain graduates into IT professionals. The new platform will address current limitations and provide a robust solution to meet all student needs.

## Overview
The platform was built using Terraform to ensure uniformity, re-useability and robustness. It integrates seamlessly with containerized applications, with all images securely stored in Amazon ECR (Elastic Container Registry).

## Features
### Infrastructure:
    • VPC (Virtual Private Cloud): A VPC is used to create a secure and isolated network for the e-learning platform.

    • ECS (Elastic Container Service): Containers for the e-learning application are managed and run without managing servers, using Fargate.

    • Application Load Balancer: Incoming traffic to the e-learning platform is distributed evenly across multiple instances by the Application Load Balancer.

    • RDS (Relational Database Service): The e-learning platform's database is managed, scaled, and operated automatically by RDS.

    • CloudWatch: Performance metrics and logs of the e-learning application are monitored and collected by CloudWatch.

    • IAM roles: Permissions and access to AWS resources for the e-learning project are controlled by IAM roles.


    • Route53: The DNS management for the e-learning platform's domain is handled by Route53.


    • SSL Certificate: Secure communication for the e-learning platform is ensured by an SSL Certificate.

### Environment Setup:
Separate environments were built for DEV, TEST, STAGING, and PROD environments.
PROD environment uses port 443.
Other environments use port 80.

## Automation:
Jenkins controller set up to automate the deployment of the infrastructure on AWS


## Best Practices
### Remote Backend:
Ensure the creation of a remote backend to prevent multiple engineers from using the state file simultaneously. This helps avoid infrastructure duplication or state file corruption.

## Prerequisites
    • Terraform installed
    • AWS CLI configured
    • Jenkins server set up (if you wish to use Jenkins for automation)

# Contributing
Feel free to open issues or submit pull requests with improvements. Contributions are always welcome.

