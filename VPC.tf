# Creating VPC
resource "aws_vpc" "VPC-one" {
  # 10.0.0.0/16
  cidr_block = var.VPC_cidr

  tags = {
    Name = var.VPC_name
  }
}

# Creating public subnet
resource "aws_subnet" "Public-sub" {
  vpc_id            = aws_vpc.VPC-one.id
  cidr_block        = var.Public_cidr
  availability_zone = var.public_sub_az

  tags = {
    Name = "public_sub"
  }
}

# Creating Internet gateway for VPC

resource "aws_internet_gateway" "VPC-internet" {
  vpc_id = aws_vpc.VPC-one.id

  tags = {
    Name = var.VPC_internet-name
  }
}

# Creating route table for public sub
resource "aws_route_table" "Public_route" {
  vpc_id = aws_vpc.VPC-one.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC-internet.id
  }

  tags = {
    Name = var.public_route-name
  }
}

# Attach route table to public subnet
resource "aws_route_table_association" "public_route_accociation" {
  # Public-sub[0], Public-sub[1]
  subnet_id      = aws_subnet.Public-sub.id
  route_table_id = aws_route_table.Public_route.id
}

# Creating private Subnet
resource "aws_subnet" "Private_sub" {
  count             = length(var.Private_cidr)
  vpc_id            = aws_vpc.VPC-one.id
  cidr_block        = element(var.Private_cidr, count.index)
  availability_zone = element(var.private-AZ, count.index)

  tags = {
    Name = "private-sub-${count.index}"
  }
}

# Creating eip for nat gateway
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "Nat-EIP"
  }
}

# Creating NAT gateway
resource "aws_nat_gateway" "nat-gateway" {
  depends_on    = [aws_eip.nat_eip, aws_subnet.Public-sub]
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.Public-sub.id

  tags = {
    Name = "Nat-gateway"
  }
}

# Creating route for nat gateway
resource "aws_route_table" "Private_route" {
  vpc_id     = aws_vpc.VPC-one.id
  depends_on = [aws_nat_gateway.nat-gateway]

  # nat-gateway[0], nat-gateway[1]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "private-route"
  }
}

# Attach private route table
resource "aws_route_table_association" "attach_private_route" {
  count      = length(var.Private_cidr)
  depends_on = [aws_route_table.Private_route]

  # Private_sub[0]--Private_route[0], Private_sub[1]--Private_route[1]
  subnet_id      = aws_subnet.Private_sub[count.index].id
  route_table_id = aws_route_table.Private_route.id
}