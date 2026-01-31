# VPC and Networking Configuration for Development Environment
project_name       = "ssf-dev"
region             = "ap-southeast-2"
cidr_block         = "10.0.0.0/16"
availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
database_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]


# EKS Node Group Configuration for Development Environment
