# Creating subnet group for RDS
resource "aws_db_subnet_group" "MySQL_subnet_group" {
  description = "private subnet group for RDS"
  subnet_ids  = [aws_subnet.Private_sub[0].id, aws_subnet.Private_sub[1].id]
  tags = {
    Name = "private-sub-DB"
  }
}

# Database Creation
resource "aws_db_instance" "mysql_db" {

  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  identifier             = var.identifier
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = var.publicly_accessible
  db_subnet_group_name   = aws_db_subnet_group.MySQL_subnet_group.name
  skip_final_snapshot    = var.skip_final_snapshot
  multi_az               = var.multi_az
  vpc_security_group_ids = ["${aws_security_group.Database_security.id}"]

  tags = {
    Name = var.DB_name
  }
}

# Output
output "rds_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}