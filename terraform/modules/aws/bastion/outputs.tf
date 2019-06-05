output "bastion_instance_ids" {
  value = "${aws_instance.bastions.*.id}"
}

output "bastion_private_ips" {
  value = "${aws_instance.bastions.*.private_ip}"
}

output "bastion_public_ips" {
  value = "${aws_instance.bastions.*.public_ip}"
}

output "bastion_security_group_id" {
  value = "${aws_security_group.bastion.id}"
}
