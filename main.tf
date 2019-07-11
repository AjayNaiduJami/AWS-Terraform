# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Bastion_SVR" {
  ami = "ami-0e55e373"
  instance_type = "t2.micro"
  tags = {
    Name = "Bastion SVR"
    Environment = "Test"
    terraform = "Yes"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "Bastian VPC"
    Environment = "Test"
    terraform = "Yes"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Bastian VPC"
    Environment = "Test"
    terraform = "Yes"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}
resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  route {
        egress_only_gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "RT Bastian"
    Environment = "Test"
    terraform = "Yes"
  }
}

resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.main.id}"

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "ACL Bastian"
    Environment = "Test"
    terraform = "Yes"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  }

  tags = {
    Name = "allow_all"
    Environment = "Test"
    terraform = "Yes"
  }
}