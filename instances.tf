resource "aws_instance" "example" {
  ami               = var.aws_ami
  instance_type     = var.aws_instatype
  security_groups   = [aws_security_group.instance.name]


  user_data = file("server_apache.sh")

  tags = {
    Name = "terraform-example"
  }
}