aws_region   = "eu-west-1"
project_name = "multi-cloud-platform"
environment  = "dev"
owner        = "selcuk"
cloud        = "aws"

vpc_cidr = "10.70.0.0/16"

public_subnet_cidrs = [
  "10.70.1.0/24",
  "10.70.2.0/24"
]

private_subnet_cidrs = [
  "10.70.11.0/24",
  "10.70.12.0/24"
]

cluster_version    = "1.35"
node_instance_type = "t3.medium"

node_desired_size = 2
node_min_size     = 1
node_max_size     = 2

ecr_repository_names = [
  "multi-cloud/api",
  "multi-cloud/frontend",
  "multi-cloud/worker"
]

