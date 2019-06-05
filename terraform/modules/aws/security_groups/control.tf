module "control" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "${var.project} ${var.environment} Control Plane"
  description = "Security group for Control Plane"
  vpc_id      = "${var.vpc_id}"

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 6443
      to_port                  = 6443
      protocol                 = "tcp"
      description              = "Allow Kubernetes API from Plane Nodes"
      source_security_group_id = "${module.common_plane.this_security_group_id}"
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
