module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "2.21.0"

    name = var.vpc_name
    cidr = var.vpc_cidr

    azs             = var.vpc_azs
    private_subnets = var.vpc_private_subnets
    public_subnets  = var.vpc_public_subnets
    # database_subnets= var.database_subnets

    enable_nat_gateway = var.vpc_enable_nat_gateway

    tags = var.vpc_tags

    
}
