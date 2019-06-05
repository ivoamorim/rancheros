variable "name_prefix" {}

variable "instance_type" {
  description = "The type of bastion instances"
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of bastion instances to launch"
  default     = 1
}

variable "ami" {
  description = "The ID of AMI to use for the instance"
}

variable "root_volume_type" {
  description = "The type of root volumes"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The size of root volumes"
  default     = "8"
}

variable "subnet_id" {}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "allow_cidrs" {
  type        = "list"
  description = "The list of CIDRs permitted to access to bastion"
  default     = ["0.0.0.0/0"]
}

variable "public_ssh_port" {
  description = "The SSH port to use from client to the bastion"
  default     = 22
}
