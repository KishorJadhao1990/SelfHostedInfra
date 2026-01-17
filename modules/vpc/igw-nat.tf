resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.availability_zones)
  subnet_id     = aws_subnet.public_subnets[count.index].id
  allocation_id = aws_eip.eip[count.index].id
    tags = {
        Name = "${var.project_name}-nat-${element(var.availability_zones, count.index)}"
    }
}

resource "aws_eip" "eip" {
  count = length(var.availability_zones)
}