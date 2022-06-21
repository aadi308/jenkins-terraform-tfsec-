module "aadi_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.17.0"

  name = "aadi-vpc"

  cidr = "10.0.0.0/16"

  azs            = ["us-east-2a", "us-east-2c"]
  public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_security_group" "sg" {
  name_prefix = "aadi"
  description = "Allow SSH inbound traffic"

}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws.aws_Security_group.id
}
