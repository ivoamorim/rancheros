module "common_plane" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "${var.project} ${var.environment} Plane Nodes"
  description = "Security group for Plane Nodes"
  vpc_id      = "${var.vpc_id}"

  ingress_with_self = [
    {
      from_port   = 4789
      to_port     = 4789
      protocol    = "udp"
      description = "Allow Canal/Flanne overlay network from all windows plane nodes"
    },
    {
      from_port   = 6783
      to_port     = 6783
      protocol    = "tcp"
      description = "Allow Weave from all plane nodes"
    },
    {
      from_port   = 6783
      to_port     = 6784
      protocol    = "udp"
      description = "Allow Weave from all plane nodes"
    },
    {
      from_port   = 8472
      to_port     = 8472
      protocol    = "udp"
      description = "Allow Flannel overlay network from all plane nodes"
    },
  ]

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 10250
      to_port                  = 10252
      protocol                 = "tcp"
      description              = "Allow Kubelet API from Control"
      source_security_group_id = "${module.control.this_security_group_id}"
    },
    {
      from_port                = 10254
      to_port                  = 10254
      protocol                 = "tcp"
      description              = "Allow Ingress controller liveness/readiness Probe API from Control"
      source_security_group_id = "${module.control.this_security_group_id}"
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "Allow SSH from Rancher"
      source_security_group_id = "${module.rancher.this_security_group_id}"
    },
    {
      from_port                = 2376
      to_port                  = 2376
      protocol                 = "tcp"
      description              = "Allow Docker API (TLS) from Rancher"
      source_security_group_id = "${module.rancher.this_security_group_id}"
    },
    {
      from_port                = 10256
      to_port                  = 10256
      protocol                 = "tcp"
      description              = "Allow KubeProxy health check from Rancher"
      source_security_group_id = "${module.rancher.this_security_group_id}"
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 3

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
