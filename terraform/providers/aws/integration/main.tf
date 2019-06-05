variable "project" {}
variable "environment" {}

variable "vpc_cidr" {}

variable "availability_zones" {
  type = "list"
}

variable "public_subnets" {
  type = "list"
}

variable "rancheros" {
  type = "map"
}


data "aws_ami" "debian" {
  most_recent = true
  owners      = [379101102735]

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64-gp2*"]
  }
}

module "network" {
  source = "../../../modules/aws/network"

  project     = "${var.project}"
  environment = "${var.environment}"

  vpc_cidr           = "${var.vpc_cidr}"
  availability_zones = "${var.availability_zones}"
  public_subnets     = "${var.public_subnets}"
}

module "security_groups" {
  source = "../../../modules/aws/security_groups"

  project     = "${var.project}"
  environment = "${var.environment}"

  vpc_id = "${module.network.vpc_id}"

  bastion_security_group_id = "${module.bastion.bastion_security_group_id}"
}

module "bastion" {
  source = "../../../modules/aws/bastion"

  name_prefix = "${var.project} ${var.environment} Bastion"
  ami         = "${data.aws_ami.debian.id}"
  subnet_id   = "${module.network.public_subnets[0]}"
  key_name    = "TestKey"
}

module "compute" {
  source = "../../../modules/aws/compute"

  project     = "${var.project}"
  environment = "${var.environment}"

  subnet_id = "${module.network.public_subnets[0]}"

  key_name = "TestKey"

  db           = "${var.db}"
  loadbalancer = "${var.loadbalancer}"
  web          = "${var.web}"

  rancheros_security_groups  = [
    "${module.security_groups.common_id}",
    "${module.security_groups.control_id}",
    "${module.security_groups.data_id}",
    "${module.security_groups.rancher_id}",
    "${module.security_groups.worker_id}",
  ]
}
