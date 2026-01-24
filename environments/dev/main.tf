module "vpc" {
  source             = "../../modules/vpc"
  project_name       = "dev-infra"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]
}

module "eks" {
  source          = "../../modules/eks"
  project_name    = "dev-infra"
  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
}
