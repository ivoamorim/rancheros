resource "aws_instance" "ec2" {
  count = "${var.instance_count}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_ids}"]

  associate_public_ip_address = "${var.associate_public_ip_address}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.shutdown_behavior}"

  root_block_device {
    volume_type = "${var.root_volume_type}"
    volume_size = "${var.root_volume_size}"
  }

  lifecycle {
    ignore_changes = [
      "ami",               # stop forcing new resource when AMI is updated
      "user_data",
      "key_name",
      "root_block_device",
    ]

    create_before_destroy = true
  }

  tags {
    Name        = "${var.project} ${var.environment} ${var.role}${count.index + 1}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Role        = "${var.role}"
    Terraform   = "true"
  }
}
