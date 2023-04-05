data "aws_caller_identity" "current" {}

module "vpc" {
  source       = "./modules/vpc"
  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
}

module "eks" {
  source = "./modules/eks"

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  machine_type    = var.machine_type
  k8s_version     = var.k8s_version
  cluster_name    = var.cluster_name
  node_count      = var.node_count
}

module "calyptia_core" {
  source = "./modules/calyptia_core"

  eks_cluster_id          = module.eks.cluster_name
  eks_oidc_provider_arn   = module.eks.oidc_provider_arn
  calyptia_core_namespace = var.calyptia_core_namespace
  service_account_name    = var.service_account_name
  calyptia_core_version   = var.calyptia_core_version
  calyptia_core_token     = var.calyptia_core_token
  instance_name           = var.instance_name
}
