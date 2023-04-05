variable "calyptia_core_namespace" {
  description = "The namespace where Calyptia Core is deployed."
  default     = "calyptia"
}

variable "service_account_name" {
  description = "The service account name used by Calyptia Core."
  default     = "calyptia-core"
}

variable "calyptia_core_version" {
  description = "Calyptia Core Helm chart version."
  default     = "1.1.2"
}

variable "calyptia_core_token" {
  description = "Token for Calyptia Core."
  sensitive   = true
}

variable "instance_name" {
  description = "Name of the Calyptia Core instance. If not specified, it will be auto-generated."
  default     = ""
}

variable "eks_cluster_id" {
  description = "EKS cluster id where Calyptia Core will be installed."
}

variable "eks_oidc_provider_arn" {
  description = "EKS cluster OIDC arn for IRSA setup of service account."
}
