output "ebs_volume_ids" {
  value = "${concat(aws_ebs_volume.ebs_volumes.*.id, aws_ebs_volume.pd_ebs_volumes.*.id)}"
}

output "ebs_volume_arns" {
  value = "${concat(aws_ebs_volume.pd_ebs_volumes.*.arn, aws_ebs_volume.ebs_volumes.*.arn)}"
}
