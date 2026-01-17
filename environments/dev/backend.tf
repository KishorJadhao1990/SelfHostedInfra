terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "eao-tf-state-ap-south-1"
    key            = "dev/network.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-ap-south-1"
    encrypt        = true
  }
}