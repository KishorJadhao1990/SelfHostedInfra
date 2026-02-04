variable "vpc_id" {type = string}
variable "cluster_name" { type = string}
variable "private_subnets" {type = list(string)}
variable "node_groups" {
  description = "EKS managed node groups definition"
  type = map(object({
    enabled          = bool
    ami_type         = string
    instance_types   = list(string)
    capacity_type    = string       
    desired_size     = number
    min_size         = number
    max_size         = number
  }))
}