module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.64.0"

  name = "${var.project} ${var.environment} VPC"
  cidr = "${var.vpc_cidr}"

  azs            = "${var.availability_zones}"
  public_subnets = "${var.public_subnets}"

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
