data "terraform_remote_state" "ec2-state" {
  backend = "s3"
  config = {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/instance"
    region = "ap-southeast-1"
  }
}