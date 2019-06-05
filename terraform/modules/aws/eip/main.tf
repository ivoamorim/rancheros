# Must not use "aws_eip_association" resource for the following reasons
# 1. always recreate associations which cause of downtime whenever instance_count increases
# 2. fails reattaching eips to instances if create_before_destroy was true

resource "aws_eip" "pd_eips" {
  count = "${var.prevent_destroy * var.instance_count}"

  vpc      = true
  instance = "${element(var.instance_ids, count.index)}"

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name        = "${var.name_prefix}${count.index + 1} EIP"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

resource "aws_eip" "eips" {
  count = "${(1 - var.prevent_destroy) * var.instance_count}"

  vpc      = true
  instance = "${element(var.instance_ids, count.index)}"

  tags {
    Name        = "${var.name_prefix}${count.index + 1} EIP"
    Project     = "${var.project}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
