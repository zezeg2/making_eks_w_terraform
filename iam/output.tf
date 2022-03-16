output "eks_cluster_role" {
    value = aws_iam_role.terraform-eks-cluster
}

output "eks_node_role" {
    value = aws_iam_role.terraform-eks-node
}