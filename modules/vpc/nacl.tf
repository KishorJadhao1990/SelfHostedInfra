resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "${var.project_name}-nacl"
  }
}

resource "aws_network_acl_association" "public_subnet_to_nacl_assoc" {
  count = length(aws_subnet.public_subnets)
  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_network_acl_association" "private_subnet_to_nacl_assoc" {
  count       = length(aws_subnet.private_subnets)
  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}

resource "aws_network_acl_association" "database_subnet_to_nacl_assoc" {
  count       = length(aws_subnet.database_subnets)
  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = aws_subnet.database_subnets[count.index].id
}