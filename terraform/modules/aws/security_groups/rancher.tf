module "rancher" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "${var.project} ${var.environment} Rancher"
  description = "Security group for MySQL"
  vpc_id      = "${var.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP from Outside"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS from Outside"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
