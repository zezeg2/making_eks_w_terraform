# variable "vpc_name" {
#     description = "Name of VPC"
#     type        = string
#     default     = "example-vpc"
# }
variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "vpc_azs" {
    description = "Availability zones for VPC"
    type        = list(string)
    default     = ["ap-northeast-2a", "ap-northeast-2b"]
}

variable "vpc_private_subnets" {
    description = "Private subnets for VPC"
    type        = list(string)
    default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "vpc_public_subnets" {
    description = "Public subnets for VPC"
    type        = list(string)
    default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "database_subnets" {
    description = "Database subnets for VPC"
    type        = list(string)
    default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "vpc_enable_nat_gateway" {
    description = "Enable NAT gateway for VPC"
    type        = bool
    default     = true
}

variable "vpc_tags" {
    description = "Tags to apply to resources created by VPC module"
    type        = map(string)
    default = {
        Terraform   = "true"
        Environment = "dev"
        "kubernetes.io/cluster/default_cluster" = "shared"
    }
}

# variable "default_ingress"{
#     description = "ingress for default security group"
#     type        = list(map(string))
#     default     = []
# }
