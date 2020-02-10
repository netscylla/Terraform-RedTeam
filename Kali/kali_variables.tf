variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-west-2"
}

variable "aws_availability_zone" {
  default = {
    "eu-west-2"="eu-west-2a"
  }
}

variable "aws_key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = {
    "eu-west-2" = "netscylla_admin"
  }
}

variable "aws_instance_type" {
  description = "EC2 instance size"
  default = "t2.micro"
}

variable "aws_ec2_role" {
  description = "Choose a AWS role, suggest using an ssm role for easy administration"
  default = {
    "eu-west-2" = "ec2_ssmrole"
  }
}

variable "aws_subnet_id" {
  default = {
    "eu-west-2" = "subnet-062a3f7d"
  }
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "30"
}

variable "node_name" {
  default = "not_used"
}
