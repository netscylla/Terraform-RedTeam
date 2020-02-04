# Terraform-RedTeam
Terraform scripts for building red-team infrastructure on AWS

## Covenant ♠
Build script for Covenant on EC2 utiltising Windows Server 2016, you'll want to modify windows2016_variables.tf and enter in your specific AWS requirements.
```
cd Covenant
terraform init
terraform plan
terraform apply
```
👷‍♀️ 👷‍♂️🤞

For the last steps, wait 5mins as Amazon SSM takes a bit of time, then use AWS Systems Manager (or RDP) to get a shell.

Check Covenent git pull worked, if so
```
cd c:\covenant\covenant
dotnet build
dotnet run
```
otherwise:
```
git clone --recurse-submodules https://github.com/cobbr/Covenant C:\Covenant\
cd c:\covenant\covenant
dotnet build
dotnet run
```
Covenant should then be accessible on the output-ip on port 7443 👍
