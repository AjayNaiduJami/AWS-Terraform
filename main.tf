
resource "aws_vpc" "Visitor_Tracking" {
  cidr_block = "172.32.0.0/16"
    
  tags = {
    Name = "Visitor_Tracking_Sasmodel_Client_DEMO"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_subnet" "Visitor_Tracking_1a" {
  vpc_id     = "${aws_vpc.Visitor_Tracking.id}"
  cidr_block = "172.32.0.0/24"
  availability_zone = "ap-south-1a"
  
    tags = {
    Name = "Visitor_Tracking_1a"
    Environment = "QA"
    Terraform = "Yes"
  }
}
resource "aws_subnet" "Visitor_Tracking_1b" {
  vpc_id     = "${aws_vpc.Visitor_Tracking.id}"
  cidr_block = "172.32.16.0/24"
  availability_zone = "ap-south-1b"
  
    tags = {
    Name = "Visitor_Tracking_1b"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_internet_gateway" "Visitor_Tracking_IGW" {
  vpc_id = "${aws_vpc.Visitor_Tracking.id}"
  tags = {
    Name = "Visitor_Tracking_IGW"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_route_table" "Visitor_Tracking_RT_1a" {
  vpc_id = "${aws_vpc.Visitor_Tracking.id}"
    
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.Visitor_Tracking_IGW.id}"
  }

  tags = {
    Name = "Visitor_Tracking_RT_1a"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_route_table_association" "Visitor_Tracking_RTA_1a" {
  subnet_id      = "${aws_subnet.Visitor_Tracking_1a.id}"
  route_table_id = "${aws_route_table.Visitor_Tracking_RT_1a.id}" 
}

resource "aws_route_table" "Visitor_Tracking_RT_1b" {
  vpc_id = "${aws_vpc.Visitor_Tracking.id}"
    
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.Visitor_Tracking_IGW.id}"
  }

  tags = {
    Name = "Visitor_Tracking_RT_1b"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_route_table_association" "Visitor_Tracking_RTA_1b" {
  subnet_id      = "${aws_subnet.Visitor_Tracking_1b.id}"
  route_table_id = "${aws_route_table.Visitor_Tracking_RT_1b.id}" 
}

resource "aws_security_group" "Visitor_Tracking_Sasmodel_Client_DEMO" {
  name        = "Visitor_Tracking_Sasmodel_Client_DEMO"
  vpc_id = "${aws_vpc.Visitor_Tracking.id}"
  description = "Visitor_Tracking_Sasmodel_Client_DEMO"

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
    Name = "Visitor_Tracking_Sasmodel_Client_DEMO"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_instance" "Visitor_Tracking_Sasmodel_Client_DEMO" {
  ami                    = "ami-01a762e6f057d4dec"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.Visitor_Tracking_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.Visitor_Tracking_Sasmodel_Client_DEMO.id}"]
  associate_public_ip_address = "1"
  key_name = "Visitortracking-demo-client-test"
  
  tags = {
    Name = "Visitor_Tracking_Sasmodel_Client_DEMO"
    Environment = "QA"
    Terraform = "Yes"
  }
}

resource "aws_lb_target_group" "VisitorTrackingSasmodel" {
  name        = "VisitorTrackingSasmodel"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${aws_vpc.Visitor_Tracking.id}"
  tags = {
    Name = "VisitorTrackingSasmodel"
    Environment = "QA"
    Terraform = "Yes" 
  }
  health_check {
    interval =  10
    port = 80
    protocol = "HTTP"
    path = "/"
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = 200
  }
}

resource "aws_lb_target_group_attachment" "VisitorTrackingSasmodel" {
  target_group_arn = "${aws_lb_target_group.VisitorTrackingSasmodel.arn}"
  target_id        = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.id}"
  port             = 80
}

resource "aws_lb" "VisitorTrackingSasmodel" {
  name               = "VisitorTrackingSasmodel"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.Visitor_Tracking_Sasmodel_Client_DEMO.id}"]
  subnets            = ["${aws_subnet.Visitor_Tracking_1a.id}","${aws_subnet.Visitor_Tracking_1b.id}"]
  tags = {
    Name = "VisitorTrackingSasmodel"
    Environment = "QA"
    Terraform = "Yes" 
  }
}
resource "aws_lb_listener" "VisitorTrackingSasmodel" {
  load_balancer_arn = "${aws_lb.VisitorTrackingSasmodel.arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.VisitorTrackingSasmodel.arn}"
  }
}