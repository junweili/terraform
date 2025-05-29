provider "aws" {
    region="us-east-1"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t2.micro"
}

variable "department" {
  description = "Department tag"
}

data "aws_subnet" "subnet1" {
    id = "subnet-3da47112"
}

resource "aws_network_interface" "network1" {
  subnet_id       = data.aws_subnet.subnet1.id
}

resource "aws_network_interface" "network2" {
  subnet_id       = data.aws_subnet.subnet1.id
}

resource "aws_instance" "machine1" {
    ami           = "ami-04b9e92b5572fa0d1"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    network_interface {
        network_interface_id = aws_network_interface.network1.id
        device_index = 0
    }
    tags = {
        Name = "e2e-a8n-terraform-github"
        department = var.department
    }
}

resource "aws_instance" "machine2" {
    ami           = "ami-04b9e92b5572fa0d1"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    network_interface {
        network_interface_id = aws_network_interface.network2.id
        device_index = 0
    }
    tags = {
        Name = "e2e-a8n-terraform-github"
        department = var.department
    }
}
