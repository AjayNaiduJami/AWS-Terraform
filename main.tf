provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "BastianVPC" {
  cidr_block = "10.0.0.0/16"
    
  tags = {
    Name = "Bastian"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_network_acl" "BastianACL" {
  vpc_id = "${aws_vpc.BastianVPC.id}"

  tags = {
    Name = "ACL Bastian"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_subnet" "BastianSubnet" {
  vpc_id     = "${aws_vpc.BastianVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  
    tags = {
    Name = "Bastian"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_internet_gateway" "BastianIGW" {
  vpc_id = "${aws_vpc.BastianVPC.id}"
}

resource "aws_route_table" "BastianRT" {
  vpc_id = "${aws_vpc.BastianVPC.id}"

  route {
    cidr_block = "10.0.1.0/16"
    gateway_id = "${aws_internet_gateway.BastianIGW.id}"
  }

  tags = {
    Name = "RT Bastian"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_security_group" "BastianSG" {
  name        = "BastianSG"
  description = "Allow http, https, SSH"
  vpc_id = "${aws_vpc.BastianVPC.id}"

  egress {
    from_port = 0
    to_port = 65535
    protocol = "all"
  }

  tags = {
    Name = "BastianSG"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_instance" "BastianSVR" {
  ami                    = "ami-0d2692b6acea72ee6"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.BastianSubnet.id}"
  associate_public_ip_address = "1"

  tags = {
    Name = "Bastian SVR"
    Environment = "Test"
    Terraform = "Yes"
  }
}