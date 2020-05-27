variable "enabled" {
  description = "Whether or not to create the modules resources"
  default     = "true"
}

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

variable "dynamodb_table_name" {
  type        = "string"
  description = "DynamoDB table name"
}

variable "dynamodb_table_arn" {
  type        = "string"
  description = "DynamoDB table ARN"
}

variable "dynamodb_indexes" {
  type        = "list"
  description = "List of DynamoDB indexes"
  default     = []
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
