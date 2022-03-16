resource "aws_eks_cluster" "terraform-eks-cluster" {
  name     = "${var.vpc_name}-${var.cluster_name}"
  role_arn = "${data.terraform_remote_state.iam.eks_cluster_role}"
  version = "1.21"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids = [aws_security_group.terraform-eks-cluster.id]
    subnet_ids         = concat(data.terraform_remote_state.vpc.vpc_public_subnets[*].id, data.terraform_remote_state.vpc.vpc_private_subnets[*].id)
    endpoint_private_access = true
    endpoint_public_access = true
  }

  depends_on = [
    data.terraform_remote_state.iam.eks_cluster_policy_attatch1,
    data.terraform_remote_state.iam.eks_cluster_policy_attatch2,
  ]

  tags = {
      Terraform   = "true"
      Environment = "dev"
  }
}

resource "aws_eks_node_group" "terraform-eks-m5-large" {
  cluster_name    = aws_eks_cluster.terraform-eks-cluster.name
  node_group_name = "terraform-eks-m5-large"
  node_role_arn   = "${data.terraform_remote_state.iam.eks_node_role}"
  subnet_ids      = data.terraform_remote_state.vpc.vpc_private_subnets[*].id
  instance_types = ["m5.large"]
  disk_size = 20

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