variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "machine_type" {
  description = "machine type"
  type        = string
  default = "t3.medium"
}

variable "node_count" {
  description = "managed node group max node count"
  type        = number
  default     = 1
  validation {
    condition     = var.node_count >= 1
    error_message = "The node_count must be bigger than 0."
  }
}

variable "k8s_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.24"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

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

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}