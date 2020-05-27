variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `eg` or `cp`)"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`, `infra`)"
}

variable "name" {
  type        = "string"
  description = "Name (e.g. `app` or `cluster`)"
}

variable "delimiter" {
  type        = "string"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
  default     = "-"
}

variable "attributes" {
  type        = "list"
  description = "Additional attributes (e.g `policy` or `role`)"
  default     = []
}

variable "tags" {
  type        = "map"
  description = "Additional tags (e.g map(`BusinessUnit`,`XYX`)"
  default     = {}
}

variable "enabled" {
  description = "Whether or not the module should create any resources"
  default     = "true"
}

variable "dynamodb_enabled" {
  description = "Whether or not to enable DynamoDB resources"
  default     = "false"
}

variable "billing_mode" {
  type        = "string"
  description = "DynamoDB Billing mode. Can be PROVISIONED or PAY_PER_REQUEST"
  default     = "PROVISIONED"
}

variable "enable_streams" {
  type        = "string"
  description = "Enable DynamoDB streams"
  default     = "false"
}

variable "stream_view_type" {
  type        = "string"
  description = "When an item in a table is modified, what information is written to the stream"

  # Valid values are `KEYS_ONLY`, `NEW_IMAGE`, `OLD_IMAGE` or `NEW_AND_OLD_IMAGES`
  default = ""
}

variable "enable_encryption" {
  type        = "string"
  description = "Enable DynamoDB server-side encryption"
  default     = "true"
}

variable "enable_point_in_time_recovery" {
  type        = "string"
  description = "Enable DynamoDB point in time recovery"
  default     = "true"
}

variable "autoscale_read_target" {
  description = "The target value (in %) for DynamoDB read autoscaling"
  default     = 50
}

variable "autoscale_write_target" {
  description = "The target value (in %) for DynamoDB write autoscaling"
  default     = 50
}

variable "autoscale_min_read_capacity" {
  description = "DynamoDB autoscaling min read capacity"
  default     = 5
}

variable "autoscale_min_write_capacity" {
  description = "DynamoDB autoscaling min write capacity"
  default     = 5
}

variable "autoscale_max_read_capacity" {
  description = "DynamoDB autoscaling max read capacity"
  default     = 20
}

variable "autoscale_max_write_capacity" {
  description = "DynamoDB autoscaling max write capacity"
  default     = 20
}

variable "hash_key" {
  type        = "string"
  description = "DynamoDB table Hash Key"
}

variable "hash_key_type" {
  type        = "string"
  description = "Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
  default     = "S"
}

variable "range_key" {
  type        = "string"
  description = "DynamoDB table Range Key"
  default     = ""
}

variable "range_key_type" {
  type        = "string"
  description = "Range Key type, which must be a scalar type: `S`, `N` or `B` for (S)tring, (N)umber or (B)inary data"
  default     = "S"
}

variable "ttl_enabled" {
  description = "Whether ttl is enabled or disabled"
  default     = "true"
}

variable "ttl_attribute" {
  type        = "string"
  description = "DynamoDB table ttl attribute"
  default     = "Expires"
}

variable "dynamodb_attributes" {
  type        = "list"
  description = "Additional DynamoDB attributes in the form of a list of mapped values"
  default     = []
}

variable "global_secondary_index_map" {
  type        = "list"
  description = "Additional global secondary indexes in the form of a list of mapped values"
  default     = []
}

variable "local_secondary_index_map" {
  type        = "list"
  description = "Additional local secondary indexes in the form of a list of mapped values"
  default     = []
}

variable "enable_autoscaler" {
  type        = "string"
  description = "Whether or not to enable DynamoDB autoscaling"
  default     = "false"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "ap-southeast-2"
}
