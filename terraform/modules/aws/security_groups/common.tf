module "common" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "${var.project} ${var.environment} Common"
  description = "Allow SSH access from Bastion"
  vpc_id      = "${var.vpc_id}"

  ingress_with_self = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "Allow Ping from all nodes"
    },
  ]

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "Allow SSH from Bastion"
      source_security_group_id = "${var.bastion_security_group_id}"
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outgoing traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
