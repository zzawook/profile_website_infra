source "amazon-ebs" "ubuntu-instance" {
  ami_name              = "kjaehyeok21-profile-ami"
  instance_type         = "t3a.nano"
  region                = "ap-southeast-1"
  force_deregister      = true
  force_delete_snapshot = true
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"] # Canonical
    most_recent = true
  }
  ssh_username = "ubuntu"
}

locals {
  created_at = timestamp()
  version    = formatdate("YYYYMMDDhhmm", local.created_at)
}