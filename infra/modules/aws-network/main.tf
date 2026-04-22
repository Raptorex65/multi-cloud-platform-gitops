
resource "aws_vpc" "multi_cloud" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public_subnetA" {
  vpc_id                  = aws_vpc.multi_cloud.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name                     = "${var.name_prefix}-public-subnetA"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "public_subnetB" {
  vpc_id                  = aws_vpc.multi_cloud.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name                     = "${var.name_prefix}-public-subnetB"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "private_subnetA" {
  vpc_id            = aws_vpc.multi_cloud.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags, {
    Name                              = "${var.name_prefix}-private-subnetA"
    "kubernetes.io/role/internal-elb" = "1"
  })
}
resource "aws_subnet" "private_subnetB" {
  vpc_id            = aws_vpc.multi_cloud.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags, {
    Name                              = "${var.name_prefix}-private-subnetB"
    "kubernetes.io/role/internal-elb" = "1"
  })
}

resource "aws_internet_gateway" "mc_igw" {
  vpc_id = aws_vpc.multi_cloud.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_eip" "mcloud_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }

  depends_on = [aws_internet_gateway.mc_igw]
}

resource "aws_nat_gateway" "mcloud_nat" {
  allocation_id = aws_eip.mcloud_nat_eip.id
  subnet_id     = aws_subnet.public_subnetA.id

  tags = {
    Name = "${var.name_prefix}-nat"
  }

  depends_on = [aws_internet_gateway.mc_igw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.multi_cloud.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mc_igw.id
  }

  tags = {
    Name = "${var.name_prefix}-rt-public"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.multi_cloud.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mcloud_nat.id
  }

  tags = {
    Name = "${var.name_prefix}-rt-private"
  }
}
resource "aws_route_table_association" "publicA_rt_assoc" {
  subnet_id      = aws_subnet.public_subnetA.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "publicB_rt_assoc" {
  subnet_id      = aws_subnet.public_subnetB.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "privateA_rt_assoc" {
  subnet_id      = aws_subnet.private_subnetA.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "privateB_rt_assoc" {
  subnet_id      = aws_subnet.private_subnetB.id
  route_table_id = aws_route_table.private_rt.id
}
