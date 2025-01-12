# Creating security group for public instance
resource "aws_security_group" "public_instance_security" {
  vpc_id      = aws_vpc.VPC-one.id
  description = "allow ssh"
  tags = {
    Name = "instance_security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rule_one" {
  security_group_id = aws_security_group.public_instance_security.id

  to_port     = 22
  from_port   = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rule_two" {
  security_group_id = aws_security_group.public_instance_security.id

  to_port     = 80
  from_port   = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rule_three" {
  security_group_id = aws_security_group.public_instance_security.id

  to_port     = 5000
  from_port   = 5000
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

# Outbound rule for public instance

resource "aws_vpc_security_group_egress_rule" "outbound_rule_one" {
  security_group_id = aws_security_group.public_instance_security.id

  to_port     = 65535
  from_port   = 0
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}


# Creating security group for Private subnet Instance
resource "aws_security_group" "Database_security" {
  description = "Allow ssh and all outbound traffic"
  vpc_id      = aws_vpc.VPC-one.id
  tags = {
    Name = "Private_sub_Database_security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rule_1" {
  security_group_id = aws_security_group.Database_security.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "10.0.0.0/16"
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rule_2" {
  security_group_id = aws_security_group.Database_security.id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
  cidr_ipv4   = "10.0.1.0/24"
}

# Outbound rule for RDS instance

resource "aws_vpc_security_group_egress_rule" "outbound_rule_1" {
  security_group_id = aws_security_group.Database_security.id

  from_port   = 0
  to_port     = 65535
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}
