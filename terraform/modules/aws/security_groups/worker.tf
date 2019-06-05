module "worker" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "${var.project} ${var.environment} Worker"
  description = "Security group for Worker nodes"
  vpc_id      = "${var.vpc_id}"

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 30000
      to_port                  = 32767
      protocol                 = "tcp"
      description              = "Allow NodePort from Rancher"
      source_security_group_id = "${module.rancher.this_security_group_id}"
    },
    {
      from_port                = 30000
      to_port                  = 32767
      protocol                 = "udp"
      description              = "Allow NodePort from Rancher"
      source_security_group_id = "${module.rancher.this_security_group_id}"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}