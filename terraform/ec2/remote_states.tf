data "terraform_remote_state" "s3-state" {
  backend = "s3"
  config = {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate"
    region = "ap-southeast-1"
  }
}
