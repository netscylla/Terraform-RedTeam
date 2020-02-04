variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "admin_password" {
  description = "Enter a Windows Administrator password for the server"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "xxx enter your region xxx"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = {
    "eu-west-2" = "xxx enter your keypair xxx"
  }
}

variable "aws_instance_type" {
  description = "EC2 instance size"
  default = "t2.micro"
}

variable "aws_ec2_role" {
  description = "Choose a AWS role, suggest using an ssm role for easy administration"
  default = {
    "eu-west-2" = "xxx enter your role xxx"
  }
}

variable "aws_subnet_id" {
  default = {
    "eu-west-2" = "xxx enter your subnet xxx"
  }
}

variable "aws_security_group" {
  default = {
    "eu-west-2" = "xxx enter your sg xxx"
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