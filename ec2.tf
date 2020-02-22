# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "ap-south-1"
}

resource "aws_instance" "server" {
  ami           = "ami-0a887e401f7654935"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.dockersg.name}"]
  key_name  = "jenkinskp"

  provisioner "file" {
  source      = "./script.sh"
  destination = "/tmp/script.sh"

  }

  provisioner "remote-exec" {
              inline = [
               "chmod +x /tmp/script.sh",
               "/tmp/script.sh"
              ]
              
    }



  connection {

    type = "ssh"
    user = "ec2-user"
    private_key = file("./jenkinskp.ppk")
    host = self.public_ip
  }

  tags = {
    Name = "Managed by terraform"
  }
}

resource "aws_security_group" "dockersg" {
  name        = "dockersg"
  description = "Allows SSH and http into machine"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}