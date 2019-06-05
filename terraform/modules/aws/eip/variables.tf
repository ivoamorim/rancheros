variable "project" {}
variable "environment" {}

variable "name_prefix" {
  description = "The prefix name to use on all EIP names"
}

variable "instance_ids" {
  description = "EC2 instance IDs to attach to EIPs"
  type        = "list"
  default     = []
}

variable "instance_count" {
  description = "The number of instances to attach to EIPs"
  default     = 0
}

variable "prevent_destroy" {
  description = "Reject with an error any plan that would destroy EIPs"
  default     = true
}
