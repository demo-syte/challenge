# BlogApp Scalable Infrastructure

This document outlines the approach for designing a highly scalable infrastructure for the BlogApp application, capable of handling 1,000,000 concurrent users. The architecture leverages various AWS services to ensure high availability, reliability, and scalability.

## Infrastructure Components

Amazon Elastic Kubernetes Service (EKS): A managed Kubernetes service that will allow us to run our containerized BlogApp \
Amazon CloudFront: AWS's Content Delivery Network (CDN) service. We'll use CloudFront to distribute BlogApp's content globally, reducing the latency experienced by our users. \
Terraform: Infrastructure as Code (IaC) will be utilized to set up and manage these resources
