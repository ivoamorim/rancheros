output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = "${module.vpc.vpc_arn}"
}

output "private_subnets" {
  description = "The list of IDs of private subnets"
  value       = "${module.vpc.private_subnets}"
}

output "public_subnets" {
  description = "The list of IDs of public subnets"
  value       = "${module.vpc.public_subnets}"
}
