terraform {
  backend "local" {}
}

module "dynamodb_table" {
  source                       = "git@github.com:lic-nz/terraform-dynamodb-module.git?ref=master"
  enabled                      = "true" 
  dynamodb_enabled             = "true"
  namespace                    = "lic"
  stage                        = "dev"
  name                         = "cluster"
  hash_key                     = "HashKey"
  range_key                    = "RangeKey"
  autoscale_write_target       = 50
  autoscale_read_target        = 50
  autoscale_min_read_capacity  = 5
  autoscale_max_read_capacity  = 20
  autoscale_min_write_capacity = 5
  autoscale_max_write_capacity = 20
  enable_autoscaler            = "true"
}
