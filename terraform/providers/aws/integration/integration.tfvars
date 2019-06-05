region = "us-east-2"

project = "3TierArchitecture"

environment = "Integration"

vpc_cidr = "192.168.0.0/23"

availability_zones = ["us-east-2a"]

public_subnets = ["192.168.1.0/24"]

rancheros = {
  instance_count             = 3
  type                       = "t2.micro"
  root_volume_type           = "gp2"
  root_volume_size           = 8
}
