output "VPC_id" {
  value = "${aws_vpc.Visitor_Tracking.id}"
}
output "VPC_cidr_block" {
  value = "${aws_vpc.Visitor_Tracking.cidr_block}"
}
output "VPC_enable_dns_support" {
  value = "${aws_vpc.Visitor_Tracking.enable_dns_support}"
}
output "VPC_enable_dns_hostnames" {
  value = "${aws_vpc.Visitor_Tracking.enable_dns_hostnames}"
}
output "VPC_owner_id" {
  value = "${aws_vpc.Visitor_Tracking.owner_id}"
}
output "Subnet_1a_id" {
  value = "${aws_subnet.Visitor_Tracking_1a.id}"
}
output "Subnet_1b_id" {
  value = "${aws_subnet.Visitor_Tracking_1b.id}"
}
output "IGW_id" {
  value = "${aws_internet_gateway.Visitor_Tracking_IGW.id}"
}
output "RT_1a_id" {
  value = "${aws_route_table.Visitor_Tracking_RT_1a.id}"
}
output "RT_1b_id" {
  value = "${aws_route_table.Visitor_Tracking_RT_1b.id}"
}
output "RTA_1a_id" {
  value = "${aws_route_table_association.Visitor_Tracking_RTA_1a.id}"
}
output "RTA_1b_id" {
  value = "${aws_route_table_association.Visitor_Tracking_RTA_1b.id}"
}
output "SG_id" {
  value = "${aws_security_group.Visitor_Tracking_Sasmodel_Client_DEMO.id}"
}
output "SG_description" {
  value = "${aws_security_group.Visitor_Tracking_Sasmodel_Client_DEMO.description}"
}
output "Instance_id" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.id}"
}
output "Instance_AvailabilityZone" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.availability_zone}"
}
output "Instance_key_name" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.key_name}"
}
output "Instance_public_dns" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.public_dns}"
}
output "Instance_public_ip" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.public_ip}"
}
output "Instance_NIC_id" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.primary_network_interface_id}"
}
output "Instance_private_dns" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.private_dns}"
}
output "Instance_private_ip" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.private_ip}"
}
output "Instance_SG_id" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.vpc_security_group_ids}"
}
output "Instance_subnet_id" {
  value = "${aws_instance.Visitor_Tracking_Sasmodel_Client_DEMO.subnet_id}"
}

output "lb_target_group_id" {
  value = "${aws_lb_target_group.VisitorTrackingSasmodel.id}"
}
output "lb_target_group_arn" {
  value = "${aws_lb_target_group.VisitorTrackingSasmodel.arn}"
}
output "lb_target_group_attachment_id" {
  value = "${aws_lb_target_group_attachment.VisitorTrackingSasmodel.id}"
}
output "lb_listener_id" {
  value = "${aws_lb_listener.VisitorTrackingSasmodel.id}"
}
output "lb_listener_arn" {
  value = "${aws_lb_listener.VisitorTrackingSasmodel.arn}"
}
