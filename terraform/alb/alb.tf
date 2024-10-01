module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "profile-website-alb"
  vpc_id  = data.terraform_remote_state.vpc-state.outputs.vpc.vpc_id
  subnets = data.terraform_remote_state.vpc-state.outputs.vpc.public_subnets

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    jenkins = {
      from_port   = 8081
      to_port     = 8081
      ip_protocol = "tcp"
      description = "Jenkins Access"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "10.0.0.0/16"
    }
  }

  access_logs = {
    bucket = "kjaehyeok21"
  }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    ex-https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.terraform_remote_state.acm-state.outputs.acm_certificate.arn

      forward = {
        target_group_key = "ex-instance"
      }
    }
    ex-jenkins = {
      port     = 8081
      protocol = "HTTPS"
      certificate_arn = data.terraform_remote_state.acm-state.outputs.acm_certificate.arn
      
      forward = {
        target_group_key = "ex-instance-jenkins"
      }
    }
    ex-mysql = {
      port     = 3306
      protocol = "HTTPS"
      certificate_arn = data.terraform_remote_state.acm-state.outputs.acm_certificate.arn
      
      forward = {
        target_group_key = "ex-instance-mysql"
      }
    }
  }

  target_groups = {
    ex-instance = {
      name_prefix      = "h1"
      protocol         = "HTTP"
      port             = 80
      target_type      = "instance"
      target_id        = data.terraform_remote_state.ec2-state.outputs.ec2_instance.id
    }
    ex-instance-jenkins = {
      name_prefix      = "h1"
      protocol         = "HTTP"
      port             = 8081
      target_type      = "instance"
      target_id        = data.terraform_remote_state.ec2-state.outputs.ec2_instance.id
    }
    ex-instance-mysql = {
      name_prefix      = "h1"
      protocol         = "HTTP"
      port             = 3306
      target_type      = "instance"
      target_id        = data.terraform_remote_state.ec2-state.outputs.ec2_instance.id
    }
  }
}