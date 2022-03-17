data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "aws_eks_cluster" "terraform-eks-cluster" {
  # name     = "${var.vpc_name}-${var.cluster_name}"
  name = "default_cluster"
  role_arn = aws_iam_role.terraform-eks-cluster.arn
  version = "1.21"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids = [data.terraform_remote_state.vpc.outputs.aws_security_group_eks]
    subnet_ids         = concat(data.terraform_remote_state.vpc.outputs.vpc_public_subnets[*], data.terraform_remote_state.vpc.outputs.vpc_private_subnets[*])
    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.terraform-eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.terraform-eks-cluster-AmazonEKSVPCResourceController,
  ]

  tags = {
      Terraform   = "true"
      Environment = "dev"
  }
}

resource "aws_eks_node_group" "terraform-eks-m5-large" {
  cluster_name    = aws_eks_cluster.terraform-eks-cluster.name
  node_group_name = "terraform-eks-m5-large"
  node_role_arn   = aws_iam_role.terraform-eks-node.arn
  subnet_ids      = data.terraform_remote_state.vpc.outputs.vpc_private_subnets[*]
  instance_types = ["m5.large"]
  disk_size = 30

  labels = {
    "role" = "terraform-eks-m5-large"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
      "Name" = "${aws_eks_cluster.terraform-eks-cluster.name}-terraform-eks-m5-large-Node"
      Terraform   = "true"
      Environment = "dev"

  }
}