
# Creating Public instance 
resource "aws_instance" "public_instance_one" {
  associate_public_ip_address = var.public_ip_associate_public_instance #By default it's true but if don't want to assign public ip than write false.
  count                       = var.public_instance_count
  subnet_id                   = aws_subnet.Public-sub.id
  # attributes
  ami           = var.Public_instance_ami
  instance_type = var.Public_instance_instance_type
  # Assign ssh-key to Instance
  key_name = aws_key_pair.Instance_key.key_name
  # Assign security group to Instance
  vpc_security_group_ids = ["${aws_security_group.public_instance_security.id}"]

  tags = {
    Name = "pubic-instance-${count.index + 1}"
  }
}

############################################
# print instance public key for ssh
output "public_instance_1_public-ip" {
  value = aws_instance.public_instance_one[*].public_ip
}

output "connection_command" {
  value = "ssh -i 'instance_key' ubuntu@publicip"
}