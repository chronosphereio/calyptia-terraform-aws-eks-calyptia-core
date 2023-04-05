locals {
  instance_name = var.instance_name != "" ? var.instance_name : "${var.eks_cluster_id}-eks-core"
}

module "core_role" {
  source                      = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/irsa?ref=v4.27.0"
  kubernetes_namespace        = var.calyptia_core_namespace
  create_kubernetes_namespace = true
  kubernetes_service_account  = var.service_account_name
  irsa_iam_policies           = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
  eks_cluster_id              = var.eks_cluster_id
  eks_oidc_provider_arn       = var.eks_oidc_provider_arn
  create_kubernetes_service_account = true

}

resource "helm_release" "calyptia_core" {
  name       = "calyptia-core"
  repository = "https://helm.calyptia.com"
  chart      = "core"
  version    = var.calyptia_core_version
  namespace = var.calyptia_core_namespace

  set {
    name  = "name"
    value = local.instance_name
  }

  set {
    name  = "project_token"
    value = var.calyptia_core_token
  }

  set {
    name  = "serviceAccount.create"
    value = false
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }
  depends_on = [module.core_role]
}