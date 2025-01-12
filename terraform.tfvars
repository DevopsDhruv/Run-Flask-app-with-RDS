
region = "ap-south-1"

###########################################
# VPC variable value
VPC_cidr = "10.0.0.0/16"
VPC_name = "VPC-one"

# Public subnet
Public_cidr   = "10.0.1.0/24"
public_sub_az = "ap-south-1a"

# Private subnet 
# you have to create minimum two private subnet in different availability zone.
Private_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
private-AZ   = ["ap-south-1a", "ap-south-1b"]


# Internet gateway
VPC_internet-name = "VPC-internet"

# Public Route table
public_route-name = "Public-route"
##########################################

##########################################
# Instance variable

# Public Instance one variable value
public_instance_count         = 1 # you can create multiple public instance by changing the value of count.
Public_instance_ami           = "ami-053b12d3152c0cc71"
Public_instance_instance_type = "t2.micro"

###################################################

# RDS variable
# subnet group for RDS
subnet_group_name = "private-sub-DB"

# Database Creation
allocated_storage   = 20
storage_type        = "gp2"
engine              = "mysql"
engine_version      = "5.7"
instance_class      = "db.t3.micro"
identifier          = "mydb"
username            = "admin"
password            = "admin54321"
publicly_accessible = false
skip_final_snapshot = true
multi_az            = false
# DB name tag
DB_name = "mydb"

###################################################
