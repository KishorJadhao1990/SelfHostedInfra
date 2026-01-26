provider "aws" {
  profile = "ssfadmin"
  region  = "ap-south-1"
  # assume_role { role_arn = "arn:aws:iam::ACCOUNT:role/TerraformRole" }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}