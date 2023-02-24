terraform {
#   backend "s3" {
#     bucket = "terraform-state-devopsthehardway-yaya"
#     key    = "ecr-terraform.tfstate"
#     region = "us-east-1"
#   }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0688ba7eeeeefe3cd"
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins"
  }

  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo apt install jenkins
  sudo systemctl start jenkins
  sudo apt update
  EOF
}

resource "aws_security_group" "jenkins_SG_uber"{
    name        = "jenkins_SG_uber"
    description = "Allow ssh and HTTP"
    vpc_id      =  "vpc-0aa085b3efb4221f9"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }
}
