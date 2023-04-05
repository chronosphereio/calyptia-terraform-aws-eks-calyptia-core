variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "machine_type" {
  description = "machine type"
  type        = string
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

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created."
  type        = string
}

variable "private_subnets" {
  description = "The private subnet list for the nodes"
  type        = list(string)
}