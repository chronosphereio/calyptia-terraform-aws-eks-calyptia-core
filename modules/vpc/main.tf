data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  name     ="${var.cluster_name}-eks-core"
  vpc_cidr = var.vpc_cidr
  //Retrieve the first 3 availability zones from the list of available zones in the current AWS region
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    ClusterName = local.name
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = local.vpc_cidr

  azs = local.azs
  # Generate a unique CIDR block for each of the first 3 availability zones within the VPC's CIDR range, using a subnet
  # mask of 8 bits
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  # Generate a unique CIDR block for each of the first 3 availability zones within the VPC's CIDR range, using a subnet
  # mask of 8 bits and an offset of 10 for the subnet index
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  manage_default_network_acl    = true
  default_network_acl_tags      = { Name = "${local.name}-default" }
  manage_default_route_table    = true
  default_route_table_tags      = { Name = "${local.name}-default" }
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = local.tags
}