
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  resource_prefix = "${var.project_name}-${var.cloud}-${var.environment}"
  common_tags = {
    project     = var.project_name
    environment = var.environment
    cloud       = var.cloud
    owner       = var.owner
    managed_by  = "terraform"
  }
}

module "aws-network" {
  source               = "../../modules/aws-network"
  name_prefix          = local.resource_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = local.azs
  tags                 = local.common_tags
}

module "aws-ecr" {
  source           = "../../modules/aws-ecr"
  repository_names = var.ecr_repository_names
  tags             = local.common_tags
}

module "aws-eks" {
  source = "../../modules/aws-eks"

  name_prefix        = local.resource_prefix
  vpc_id             = module.aws-network.vpc_id
  public_subnet_ids  = module.aws-network.public_subnet_ids
  private_subnet_ids = module.aws-network.private_subnet_ids
  cluster_version    = var.cluster_version
  node_instance_type = var.node_instance_type
  node_min_size      = var.node_min_size
  node_max_size      = var.node_max_size
  node_desired_size  = var.node_desired_size
  tags               = local.common_tags
}

module "aws-eks-addons" {
  source = "../../modules/aws-eks-addons"
  
  cluster_name       = module.aws-eks.cluster_name
  cluster_version    = var.cluster_version
  oidc_provider_arn  = module.aws-eks.oidc_provider_arn
  oidc_provider_url  = module.aws-eks.oidc_provider_url
  tags               = local.common_tags
  
}