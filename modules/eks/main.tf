data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

locals {
  name     ="${var.cluster_name}-eks-core"

  tags = {
    ClusterName = local.name
  }
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = local.name
  subnet_ids                     = var.private_subnets
  cluster_endpoint_public_access = true
  # EKS Addons
  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  tags = local.tags

  vpc_id = var.vpc_id

  cluster_version = var.k8s_version

  eks_managed_node_group_defaults = {
    iam_role_additional_policies = {
      # Not required, but used in the example to access the nodes to inspect mounted volumes
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
  }

  eks_managed_node_groups = {
    mg_5 = {
      node_group_name = "managed-ondemand"
      instance_types  = [var.machine_type]
      min_size        = 1
      max_size        = var.node_count
      subnet_ids      = var.private_subnets
    }
  }
}
