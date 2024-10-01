module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 3.0"

  zones = {
    "kjaehyeok21.dev" = {
      comment = "profile website hosting zone"
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_route53_record" "kjaehyeok21_A" {
  zone_id = module.zones.route53_zone_zone_id["kjaehyeok21.dev"]
  name    = "kjaehyeok21.dev"
  type    = "A"
  alias {
    name    = data.terraform_remote_state.alb-state.outputs.alb.dns_name
    zone_id = data.terraform_remote_state.alb-state.outputs.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "kjaehyeok21_validation" {
  for_each = {
    for dvo in data.terraform_remote_state.acm-state.outputs.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id = module.zones.route53_zone_zone_id["kjaehyeok21.dev"]
  name    = each.value.name
  type    = each.value.type
  ttl     = 3600
  records = [
    each.value.record,
  ]
}