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

module "db" {
  source        = "../../modules/db"
  ami           = var.ami
  vpc_id        = module.vpc.vpc_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.database_subnets[0]
  key_name      = var.key_name
  depends_on    = [module.vpc]

  tags          = var.tags
}


# module "postgres_standby_db" {
#   source        = "../../modules/db"
#   vpc_id        = module.vpc.vpc_id
#   ami           = var.ami
#   instance_type = var.instance_type
#   subnet_id     = module.vpc.database_subnets[1]
#   key_name      = var.key_name
#   depends_on    = [module.vpc]

#   tags = {
#     Name        = "${var.project_name}-standby-db"
#     Environment = "development"
#   }
# }
