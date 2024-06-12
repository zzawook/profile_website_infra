terraform {
  backend "s3" {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/network"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
