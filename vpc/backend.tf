terraform {
  required_providers {
    aws ={
      source = "hashicorp/aws"
      # version = "~> 3.27"
    }
  }
  # required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "jbytftests3-apnortheast2-tfstate"
    key            = "making_eks/vpc/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
}
}