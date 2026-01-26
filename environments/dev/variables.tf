variable "region" { type = string }
variable "project_name" { type = string }
variable "cidr_block" { type = string }
variable "availability_zones" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "database_subnets" { type = list(string) }
