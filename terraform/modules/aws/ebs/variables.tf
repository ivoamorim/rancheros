variable "project" {}
variable "environment" {}

variable "name_prefix" {
  description = "The prefix name to use on all EBS volume names"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to create in"
}

variable "instance_ids" {
  description = "The EC2 instance IDs to attach to EBS volumes"
  type        = "list"
  default     = []
}

variable "instance_count" {
  description = "The number of instances to attach to EBS volumes"
  default     = 0
}

variable "device_name" {
  description = "The device name to expose to the instance"
  default     = "/dev/xvdb"
}

variable "mount_point" {
  description = "The position the EBS volumes are accessible."
}

variable "size" {
  description = "The size of the drive in GiBs. New size cannot be smaller than existing size"
}

variable "type" {
  description = "The type of EBS volume"
  default     = "gp2"
}

variable "prevent_destroy" {
  description = "Reject with an error any plan that would destroy EBS volumes"
  default     = true
}
