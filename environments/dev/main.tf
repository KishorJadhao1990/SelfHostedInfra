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
  cluster_name    = var.cluster_name
  private_subnets = module.vpc.private_subnets
  node_groups     = var.node_groups
  depends_on      = [module.vpc]
}
