output "eip_ids" {
  value = "${concat(aws_eip.eips.*.association_id, aws_eip.pd_eips.*.association_id)}"
}

output "eip_public_ips" {
  value = "${concat(aws_eip.pd_eips.*.public_ip, aws_eip.eips.*.public_ip)}"
}
