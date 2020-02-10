variable "home_ip" {
  description = "Enter a whitelisted ip/range in CIDR format"
}

resource "aws_security_group" "Kali" {
  name = "Kali"
  description = "Kali Firewall"
  vpc_id  = " xxx add vpc xxx"
  revoke_rules_on_delete= true

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.home_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
