module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.21.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.29"
  subnet_ids      = data.aws_subnets.vpc_subnets.ids

  tags = {
    Environment = "training"
  }

  vpc_id = aws_default_vpc.default_vpc.id

  # EKS Managed Node Groups
  eks_managed_node_groups = {
    worker-group-1 = {
      name           = "worker-group-1"
      instance_types = ["t2.small"]
      min_size       = 2
      max_size       = 3
      desired_size   = 2

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 20
            volume_type = "gp2"
          }
        }
      }

      vpc_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }

    worker-group-2 = {
      name           = "worker-group-2"
      instance_types = ["t2.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 20
            volume_type = "gp2"
          }
        }
      }

      vpc_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}
