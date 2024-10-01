data "terraform_remote_state" "ec2-state" {
  backend = "s3"
  config = {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/instance"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "acm-state" {
  backend = "s3"
  config = {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/acm"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "alb-state" {
  backend = "s3"
  config = {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/alb"
    region = "ap-southeast-1"
  }
}