data "terraform_remote_state" "vpc" {

    backend = "s3"
    config = {
        bucket         = "jbytftests3-apnortheast2-tfstate"
        key            = "making_eks/vpc/terraform.tfstate"
        region         = "ap-northeast-2"
     }
}

# data "terraform_remote_state" "iam" {

#     backend = "s3"
#     config = {
#         bucket         = "jbytftests3-apnortheast2-tfstate"
#         key            = "making_eks/iam/terraform.tfstate"
#         region         = "ap-northeast-2"
#      }
# }

# data "terraform_remote_state" "eks" {

#     backend = "s3"
#     config = {
#         bucket         = "jbytftests3-apnortheast2-tfstate"
#         key            = "making_eks/eks/terraform.tfstate"
#         region         = "ap-northeast-2"
#      }
# }