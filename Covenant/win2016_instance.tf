provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = var.aws_region
}

data "template_file" "init" {
    template = <<EOF
<script>
  winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
</script>
<powershell>
  netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
  $admin = [ADSI]("WinNT://./administrator, user")
  $admin.SetPassword("${var.admin_password}")
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  choco feature enable -n=allowGlobalConfirmation
  mkdir C:\Covenant
  Add-MpPreference -ExclusionPath "C:\Covenant"
  Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
  choco install git
  choco install dotnetcore --version=2.2.2 
  choco install dotnetcore-sdk --version=2.2.207
  git clone --recurse-submodules https://github.com/cobbr/Covenant C:\Covenant\
</powershell>
EOF
}

data "aws_ami" "Windows_2016" {
  most_recent = true
  owners= ["amazon"]
  filter {
    name = "name"
    values = ["Windows_Server-2016-English-Core-Base*"]
  }
  filter {
    name = "is-public"
    values = ["true"]
  }
  filter {
	name = "virtualization-type"
	values = ["hvm"]
  }
  name_regex = "Windows_Server-2016-English-Core-Base*"
}

resource "aws_instance" "Windows_2016" {
  connection {
    type = "winrm"
    user = "Administrator"
    password = var.admin_password
  }
  instance_type = var.aws_instance_type
  ami = data.aws_ami.Windows_2016.image_id
  availability_zone = [lookup(var.aws_availability_zone, var.aws_region)]
  security_groups = [lookup(var.aws_security_group, var.aws_region)]
  key_name = [lookup(var.key_name, var.aws_region)]
  tags = {
    Name = "Covenant"
  }

  iam_instance_profile = lookup(var.aws_ec2_role, var.aws_region)
  subnet_id = lookup(var.aws_subnet_id, var.aws_region)
  vpc_security_group_ids = [lookup(var.aws_security_group, var.aws_region)]
  user_data = data.template_file.init.rendered
  get_password_data = "true"
}

output "ip" {
 
value=aws_instance.Windows_2016.public_ip
 
}
