output "cluster_name" {
  value = module.eks.cluster_name
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_cert" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_auth_token" {
  value = data.aws_eks_cluster_auth.this.token
}