provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = var.aws_region
}

data "aws_ami" "Kali" {
  most_recent = true
  owners= ["679593333241"]
  filter {
    name = "name"
    values = ["Kali*"]
  }
  filter {
    name = "is-public"
    values = ["true"]
  }
  filter {
	name = "virtualization-type"
	values = ["hvm"]
  }
  name_regex = "Kali*"
}

resource "aws_instance" "Kali" {
  connection {
    type = "ssh"
    user = "ec2-user"
  }
  instance_type = var.aws_instance_type
  ami = data.aws_ami.Kali.image_id
  availability_zone = lookup(var.aws_availability_zone, var.aws_region)
  key_name = lookup(var.aws_key_name, var.aws_region)
  tags = {
    Name = "Kali"
  }
  iam_instance_profile = lookup(var.aws_ec2_role, var.aws_region)
  subnet_id = lookup(var.aws_subnet_id, var.aws_region)
  vpc_security_group_ids = [aws_security_group.Kali.id]
  user_data = data.template_file.init.rendered
  get_password_data = "true"

}

output "ip" {
 
value=aws_instance.Kali.public_ip
 
}
