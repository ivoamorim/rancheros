data "aws_subnet" "selected" {
  id = "${var.subnet_id}"
}

# case: prevent_destroy
resource "aws_ebs_volume" "pd_ebs_volumes" {
  count = "${var.prevent_destroy * var.instance_count}"

  availability_zone = "${data.aws_subnet.selected.availability_zone}"
  size              = "${var.size}"
  type              = "${var.type}"

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name            = "${var.name_prefix}${count.index + 1} ${var.mount_point}"
    Project         = "${var.project}"
    Environment     = "${var.environment}"
    Mount_Point     = "${var.mount_point}"
    Terraform       = "true"
    Prevent_Destroy = "true"
  }
}

# case: not prevent_destroy
resource "aws_ebs_volume" "ebs_volumes" {
  count = "${(1 - var.prevent_destroy) * var.instance_count}"

  availability_zone = "${data.aws_subnet.selected.availability_zone}"
  size              = "${var.size}"
  type              = "${var.type}"

  tags {
    Name            = "${var.name_prefix}${count.index + 1} ${var.mount_point}"
    Project         = "${var.project}"
    Environment     = "${var.environment}"
    Mount_Point     = "${var.mount_point}"
    Terraform       = "true"
    Prevent_Destroy = "false"
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  count = "${var.instance_count}"

  device_name = "${var.device_name}"
  volume_id   = "${element(concat(aws_ebs_volume.pd_ebs_volumes.*.id, aws_ebs_volume.ebs_volumes.*.id), count.index)}"
  instance_id = "${element(var.instance_ids, count.index)}"

  lifecycle {
    ignore_changes = ["ebs_block_device"] # stop forcing new resource when instance_id is computed
  }
}
