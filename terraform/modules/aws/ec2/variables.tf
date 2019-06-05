variable "project" {}
variable "environment" {}
variable "role" {}

variable "instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "instance_count" {
  description = "The number of instances to launch"
  default     = 0
}

variable "ami" {
  description = "The ID of AMI to use for the instance"
}

variable "user_data" {
  description = "The user data to provide when launching the instance. The instances already launched ignore this change"
  default     = ""
}

variable "subnet_id" {
  description = "The VPC Subnet ID to create in. This change will recreate instances"
}

variable "key_name" {
  description = "The key name to use for the instance. The instances already launched ignore this change"
}

variable "security_group_ids" {
  description = "The list of security group IDs to associate with"
  type        = "list"
  default     = []
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address. This change will recreate instances"
  default     = true
}

variable "source_dest_check" {
  description = "False if used for NAT or VPNs. Packets will be dropped when the destination address does not match the instance."
  default     = true
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = true
}

variable "shutdown_behavior" {
  description = "Shutdown behavior for the instance. Insert either 'terminate' or 'stop'" # https://amzn.to/303HUBv
  default     = "stop"
}

variable "root_volume_type" {
  description = "The type of root block devices. The instances already launched ignore this change"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The size of root block devices. The instances already launched ignore this change"
  default     = "8"
}
