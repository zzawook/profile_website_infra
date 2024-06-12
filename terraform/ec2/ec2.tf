data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "kjaehyeok21-instance1"

  instance_type          = "t3a.nano"
  key_name               = "kjaehyeok21"
  monitoring             = true
  vpc_security_group_ids = [data.terraform_remote_state.s3-state.outputs.vpc.default_security_group_id]
  subnet_id              = data.terraform_remote_state.s3-state.outputs.vpc.public_subnets[0]
  ami                    = data.aws_ami.ubuntu.id

  tags = {
  }
}
