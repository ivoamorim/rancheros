output "common_id" {
  value = "${module.common.this_security_group_id}"
}

output "common_plane_id" {
  value = "${module.common_plane.this_security_group_id}"
}

output "control_id" {
  value = "${module.control.this_security_group_id}"
}

output "data_id" {
  value = "${module.data.this_security_group_id}"
}

output "rancher_id" {
  value = "${module.rancher.this_security_group_id}"
}

output "worker_id" {
  value = "${module.rancher.this_security_group_id}"
}
