terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # 5.0.0 removed support for classiclink, breaking the provider. Pinning to 4.67.0 is the only known workaround for now https://github.com/terraform-aws-modules/terraform-aws-vpc/pull/941
      version = "4.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
}
