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
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.BastianIGW.id}"
  }

  tags = {
    Name = "RT Bastian"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_route_table_association" "RTABastian" {
  subnet_id      = "${aws_subnet.BastianSubnet.id}"
  route_table_id = "${aws_route_table.BastianRT.id}"
}

resource "aws_security_group" "BastianSG" {
  name        = "BastianSG"
  vpc_id = "${aws_vpc.BastianVPC.id}"
  description = "Allow http, https, SSH"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BastianSG"
    Environment = "Test"
    Terraform = "Yes"
  }
}

resource "aws_instance" "BastianSVR" {
  ami                    = "ami-009110a2bf8d7dd0a"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.BastianSubnet.id}"
  vpc_security_group_ids = ["${aws_security_group.BastianSG.id}"]
  associate_public_ip_address = "1"
  key_name = "Terraform"
  
  tags = {
    Name = "Bastian SVR"
    Environment = "Test"
    Terraform = "Yes"
  }
}