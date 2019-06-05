module "data" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "${var.project} ${var.environment} Data Plane"
  description = "Security group for Data Plane"
  vpc_id      = "${var.vpc_id}"

  ingress_with_self = [
    {
      from_port   = 2379
      to_port     = 2380 
      protocol    = "tcp"
      description = "Allow etcd client/server from Data Plane"
    },
  ]

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 2379
      to_port                  = 2380
      protocol                 = "tcp"
      description              = "Allow etcd client/server from Control Plane"
      source_security_group_id = "${module.control.this_security_group_id}"
    },
    {
      from_port                = 8472
      to_port                  = 8472
      protocol                 = "udp"
      description              = "Allow flannel overlay network from Control Plane"
      source_security_group_id = "${module.control.this_security_group_id}"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
