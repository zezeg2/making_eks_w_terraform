output "eks_cluster_policy_attatch1" {
  value = aws_iam_role_policy_attachment.terraform-eks-cluster-AmazonEKSClusterPolicy
}

output "eks_cluster_policy_attatch2" {
  value = aws_iam_role_policy_attachment.terraform-eks-cluster-AmazonEKSVPCResourceController
}

output "eks_cluster_role" {
    value = aws_iam_role.terraform-eks-cluster
}

output "eks_node_role" {
    value = aws_iam_role.terraform-eks-node
}