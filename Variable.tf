variable "access" {
  type = string
}

variable "secret" {
  type = string
}

variable "region" {
  type = string
}

##################################################
# VPC variable 
variable "VPC_cidr" {
  type = string
}
variable "VPC_name" {
  type = string
}


# public sub variable 
variable "Public_cidr" {
  type = string
}
variable "public_sub_az" {
  type = string
}



# private sub variable
variable "Private_cidr" {
  type = list(string)
}
variable "private-AZ" {
  type = list(string)
}



# Internet gateway variable
variable "VPC_internet-name" {
  type = string
}



# Route table name
variable "public_route-name" {
  type = string
}
###################################################

# Instance variable
# Public instance variable
variable "public_instance_count" {
  type = number
}

variable "Public_instance_ami" {
  type = string
}

variable "Public_instance_instance_type" {
  type = string
}

variable "public_ip_associate_public_instance" {
  description = "associate public ip address to public instance"
  type        = bool
  default     = true
}
##################################################

# Database variable
# subnet group variable
variable "subnet_group_name" {
  type = string
}

# Database variable

variable "allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "identifier" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "publicly_accessible" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}

variable "multi_az" {
  type = bool
}

variable "DB_name" {
  type = string
}
##################################################
