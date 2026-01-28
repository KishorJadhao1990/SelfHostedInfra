module "vpc" {
  source             = "../../modules/vpc"
  project_name       = var.project_name
  region             = var.region
  cidr_block         = var.cidr_block
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  database_subnets   = var.database_subnets
}

module "eks" {
  source          = "../../modules/eks"
  vpc_id          = module.vpc.vpc_id
  cluster_name    = "${var.project_name}-eks-cluster"
  private_subnets = module.vpc.private_subnets

  // Node Group Configurations
  node_groups = {
    compute  = {
      enabled        = true
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.large"]
      capacity_type  = "ON_DEMAND"
      desired_size   = 2
      min_size       = 1
      max_size       = 4
    },

    general  = {
      enabled        = true
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      desired_size   = 4
      min_size       = 2
      max_size       = 6
    }
  }

  depends_on = [module.vpc]
}
