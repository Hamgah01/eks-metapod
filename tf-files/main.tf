terraform {
  backend "s3" {
    bucket       = "hamda-nicole-bucket"
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

}

locals {
  cluster_name = "nh-k8s-cluster"
}
