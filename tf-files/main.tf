terraform {
  backend "s3" {
    bucket       = "mitch-week-5-bucket"
    key          = "terraform/tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "aws" {
  region = var.region
  profile                  = "week-5-user"
  shared_config_files      = ["/Users/mitchelllewsey/.aws/config"]
  shared_credentials_files = ["/Users/mitchelllewsey/.aws/credentials"]
}

locals {
  cluster_name = "mitch-k8s-cluster"
}
