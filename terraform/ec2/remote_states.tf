data "terraform_remote_state" "s3-state" {
  backend = "s3"
  config = {
    bucket = "kjaehyeok21"
    key    = "infra/tfstate/network"
    region = "ap-southeast-1"
  }
}
