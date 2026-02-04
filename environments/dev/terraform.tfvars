# VPC and Networking Configuration for Development Environment
project_name       = "ssf-dev"
region             = "ap-south-1"
cidr_block         = "10.0.0.0/16"
availability_zones = ["ap-south-1a", "ap-south-1b"]
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
database_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]


# EKS Node Group Configuration for Development Environment
cluster_name = "ssf-dev-eks-cluster"
node_groups = {
  general = {
    enabled        = true
    ami_type       = "AL2023_x86_64_STANDARD"
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 4
    min_size       = 2
    max_size       = 6
  },
  compute = {
    enabled        = false
    ami_type       = "AL2023_x86_64_STANDARD"
    instance_types = ["t3.large"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 2
    min_size       = 1
    max_size       = 4
  }
}


# Database Server configuration for Development Environment
ami           = "ami-019715e0d74f695be" # Ubuntu 24.04 LTS AMI ID in us-east-1
instance_type = "m6i.large"
key_name      = "ec2pair"
tags = {
    Name        = "ssf-dev-postgres-db"
    Environment = "development"
}