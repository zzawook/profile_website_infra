data "aws_ami" "profile_website" {
  most_recent = true

  filter {
    name   = "name"
    values = ["kjaehyeok21-profile-ami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["768114501818"]
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "kjaehyeok21-instance1"

  instance_type          = "t3a.medium"
  key_name               = "kjaehyeok21"
  monitoring             = true
  vpc_security_group_ids = [data.terraform_remote_state.s3-state.outputs.vpc.default_security_group_id]
  subnet_id              = data.terraform_remote_state.s3-state.outputs.vpc.public_subnets[0]
  ami                    = data.aws_ami.profile_website.id
  availability_zone      = "ap-southeast-1a"

  root_block_device = [{
    volume_size = 32
    volume_type = "gp3"
  }]

  associate_public_ip_address = true
}
