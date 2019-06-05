variable "rancheros" {
  default = {
    instance_count   = 3
    type             = "t2.micro"
    root_volume_size = 20
  }
}

variable "rancheros_security_groups" {
  type    = "list"
  default = []
}


data "aws_ami" "rancheros" {
  most_recent = true
  owners      = [605812595337]

  filter {
    name   = "name"
    values = ["rancheros-v1.5.2-hvm*"]
  }
}


module "rancheros" {
  source = "../ec2"

  project     = "${var.project}"
  environment = "${var.environment}"
  role        = "RancherOS"

  ami                = "${data.aws_ami.rancheros.id}"
  subnet_id          = "${var.subnet_id}"
  security_group_ids = "${var.rancheros_security_groups}"

  instance_count   = "${lookup(var.rancheros, "instance_count")}"
  instance_type    = "${lookup(var.rancheros, "type")}"
  key_name         = "${var.key_name}"
  root_volume_size = "${lookup(var.rancheros, "root_volume_size")}"
}

module "eips" {
  source = "../eip"

  project     = "${var.project}"
  environment = "${var.environment}"
  name_prefix = "${var.project} ${var.environment} RancherOS"

  instance_ids   = "${module.rancheros.instance_ids}"
  instance_count = "${lookup(var.rancheros, "instance_count")}"
}


output "rancheros_instance_ids" {
  value = "${module.rancheros.instance_ids}"
}

output "rancheros_private_ips" {
  value = "${module.rancheros.private_ips}"
}

output "rancheros_public_ips" {
  value = "${module.rancheros.public_ips}"
}
