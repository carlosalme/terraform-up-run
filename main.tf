provider "aws" {
  region = "us-east-1"
  access_key = "AKIA2UCCDYN6UDNHDR6A"
  secret_key = "6Wymk73xlCY5tys3ZZKkOiAYGJiEntRo6bSGRiD8"
}

resource "aws_instance" "example" {
  ami = "ami-0dba2cb6798deb6d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<EOF
     		 #!/bin/bash
		 echo "Hollo, World " > index.html
		 nohup busybox httpd -f -p 8080 &
		 EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = 80
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
