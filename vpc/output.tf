output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

output "vpc_public_subnets_arn" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnet_arns
}

output "vpc_private_subnets" {
  description = "IDs of the VPC's private subnets"
  value       = module.vpc.private_subnets
}

output "vpc_private_subnets_arn" {
  description = "IDs of the VPC's private subnets"
  value       = module.vpc.private_subnet_arns
}

output "aws_security_group_eks"{
  description = "aws security group for eks"
  value = module.security-group.security_group_id
}