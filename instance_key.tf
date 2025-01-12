# Creating Instance key

resource "aws_key_pair" "Instance_key" {
  key_name   = "Instance_key"
  public_key = file("${path.module}/instance_key.pub")
}