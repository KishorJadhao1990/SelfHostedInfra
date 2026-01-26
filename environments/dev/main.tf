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

#   source          = "../../modules/eks"
#   project_name    = "dev-infra"
#   private_subnets = module.vpc.private_subnets
#   vpc_id          = module.vpc.vpc_id
# }
