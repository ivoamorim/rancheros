variable "project" {}
variable "environment" {}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/23"
}

variable "availability_zones" {
  description = "availability zones for the VPC"
  type        = "list"
  default     = ["us-east-2a"]
}

variable "public_subnets" {
  description = "The public subnetworks for the VPC"
  type        = "list"
  default     = ["10.0.0.0/24"]
}
