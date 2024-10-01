resource "aws_acm_certificate" "cert" {
  domain_name       = "kjaehyeok21.dev"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}