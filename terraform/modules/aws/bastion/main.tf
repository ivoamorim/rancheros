data "aws_subnet" "selected" {
  id = "${var.subnet_id}"
}

resource "aws_security_group" "bastion" {
  name        = "${var.name_prefix} Security Group"
  description = "Enable SSH access to the bastion host from external via SSH port"
  vpc_id      = "${data.aws_subnet.selected.vpc_id}"

  ingress {
    from_port   = "${var.public_ssh_port}"
    to_port     = "${var.public_ssh_port}"
    protocol    = "tcp"
    cidr_blocks = "${var.allow_cidrs}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow all outgoing traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${var.name_prefix} Security Group"
    Terraform = "true"
  }
}

resource "aws_instance" "bastions" {
  count = "${var.instance_count}"

  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"

  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  disable_api_termination = "${var.disable_api_termination}"
  key_name                = "${var.key_name}"

  root_block_device = {
    volume_type = "${var.root_volume_type}"
    volume_size = "${var.root_volume_size}"
  }

  lifecycle {
    ignore_changes        = ["ami"]
    create_before_destroy = true
  }

  tags {
    Name      = "${var.name_prefix}${count.index + 1}"
    Terraform = "true"
  }
}
