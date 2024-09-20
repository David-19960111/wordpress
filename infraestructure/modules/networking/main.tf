#Virtual Private Cloud
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true 

  tags = {
    Name = var.tag_vpc
  }
}

#Internet Gateway
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.tag_igw
  }
}

#Subnets

# Subnets públicas
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.my_vpc.id 
  cidr_block = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.public_subnets_tag}-${count.index + 1}"
  }
}

# Subnets privadas
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr)

  vpc_id            = aws_vpc.my_vpc.id 
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private subnet ${count.index + 1}"
  }
}

# Subnets de base de datos (privadas)
resource "aws_subnet" "private_db_subnets" {
  count = length(var.private_subnet_db_cidr)

  vpc_id            = aws_vpc.my_vpc.id 
  cidr_block        = element(var.private_subnet_db_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private db subnet ${count.index + 1}"
  }
}

#Elastic Ip
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.my_ig]
  count = length(var.public_subnet_cidr)
  tags = {
    Name = "${var.tag_nat}-eip-${count.index}"
  }
}

# NAT Gateway One
resource "aws_nat_gateway" "ngw" {
  count = length(aws_subnet.public_subnet)
  subnet_id = aws_subnet.public_subnet[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
  connectivity_type = var.nat_connectivity_type
  tags = {
    Name = "${var.tag_nat}-${count.index}"
  }
}

#Route tables
resource "aws_route_table" "my_route_table_public" {
  vpc_id = aws_vpc.my_vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
  tags = {
    Name = var.route_table_tag
  }
}

resource "aws_route_table" "my_route_table_private_one" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[0].id 
  }

  tags = {
    Name = var.route_table_tag
  }
}

resource "aws_route_table" "my_route_table_private_two" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[1].id 
  }

  tags = {
    Name = var.route_table_tag
  }
}


#Route Tables Association
resource "aws_route_table_association" "public_subnets_route_association" {
  count = length(var.public_subnet_cidr)
  route_table_id = aws_route_table.my_route_table_public.id
  subnet_id = element(aws_subnet.public_subnet[*].id, count.index)
}

resource "aws_route_table_association" "private_subnets_route_association" {
  count = length(var.private_subnet_cidr)
  route_table_id = aws_route_table.my_route_table_private_one.id 
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
}

resource "aws_route_table_association" "private_subnets_data_route_association" {
  count = length(var.private_subnet_db_cidr)
  route_table_id = aws_route_table.my_route_table_private_two.id 
  subnet_id = element(aws_subnet.private_db_subnets[*].id, count.index)
}