module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "profile-website-rds-dev"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"   
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "profile_website"
  username = "kjaehyeok21"
  password = "airbusa380861"
  port     = "3306"

  manage_master_user_password = false

  iam_database_authentication_enabled = true

  subnet_ids = data.terraform_remote_state.s3-state.outputs.vpc.public_subnets
  vpc_security_group_ids = [data.terraform_remote_state.s3-state.outputs.vpc.default_security_group_id]

  publicly_accessible = true

  create_db_subnet_group = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

#   backup_window      = "03:00-06:00"  


  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}