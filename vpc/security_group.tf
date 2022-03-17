data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
  name = "${var.vpc_name}-sg"
  vpc_id = "${module.vpc.vpc_id}"
  use_name_prefix = "false"
  ingress_with_cidr_blocks = [
    {
      from_port   = 443                                #인바운드 시작 포트
      to_port     = 443                                #인바운드 끝나는 포트
      protocol    = "tcp"                              #사용할 프로토콜
      description = "https"                            #설명
      cidr_blocks = local.workstation-external-cidr                        #허용할 IP 범위
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0"
    }
]
  egress_with_cidr_blocks = [
    {
      from_port   = 0                                #아웃바운드 시작 포트
      to_port     = 0                                #아웃바운드 끝나는 포트
      protocol    = "-1"                             #사용할 프로토콜
      description = "all"                            #설명
      cidr_blocks = "0.0.0.0/0"                      #허용할 IP 범위
    }
  ]
}