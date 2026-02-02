variable "region" { type = string }
variable "project_name" { type = string }
variable "cidr_block" { type = string }
variable "availability_zones" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "database_subnets" { type = list(string) }

variable "cluster_name" { type = string }
variable "node_groups" {
  type = map(object({
    enabled        = bool
    ami_type       = string
    instance_types = list(string)
    capacity_type  = string # ON_DEMAND | SPOT
    desired_size   = number
    min_size       = number
    max_size       = number
  }))
}


variable "instance_type" { type = string }
variable "key_name" { type = string }