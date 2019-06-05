variable "region" {}

provider "aws" {
  region = "${var.region}"
}

#terraform {
#  backend "s3" {
#    bucket         = "terraform-state.projectname.com"
#    key            = "project/integration/terraform.tfstate"
#    region         = "${var.region}"
#    dynamodb_table = "terraform-lock"
#  }
#}

