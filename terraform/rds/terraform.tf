terraform {
  backend "s3" {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/rds"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
