resource "aws_subnet" "public_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    "Name" = "${var.project_name}-${var.availability_zones[count.index]}-public-subnet"
    "kubernetes.io/cluster/${var.project_name}-eks-cluster" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    "Name" = "${var.project_name}-${var.availability_zones[count.index]}-private-subnet"
    "kubernetes.io/cluster/${var.project_name}-eks-cluster" = "owned"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "database_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.database_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    "Name" = "${var.project_name}-${var.availability_zones[count.index]}-database-subnet"
  }
}

resource "aws_route_table" "public_subnet_rt" {
  vpc_id       = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.availability_zones[count.index]}-public-subnet-rt"
  }
}

resource "aws_route_table" "private_subnet_rt" {
  vpc_id        = aws_vpc.vpc.id
  count         = length(aws_subnet.private_subnets)
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "${var.project_name}-${var.availability_zones[count.index]}-private-subnet-rt"
  }
}

resource "aws_route_table" "database_subnet_rt" {
  vpc_id        = aws_vpc.vpc.id
  count         = length(aws_subnet.database_subnets)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "${var.project_name}-${var.availability_zones[count.index]}-database-subnet-${element(var.availability_zones, count.index)}-rt"
  }
}

resource "aws_route_table_association" "public_subnet_to_rt_assoc" {
    count          = length(aws_subnet.public_subnets)
    subnet_id      = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.public_subnet_rt.id
}

resource "aws_route_table_association" "private_subnet_to_rt_assoc" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_subnet_rt[count.index].id
}

resource "aws_route_table_association" "database_subnet_to_rt_assoc" {
  count          = length(aws_subnet.database_subnets)
  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = aws_route_table.database_subnet_rt[count.index].id
}