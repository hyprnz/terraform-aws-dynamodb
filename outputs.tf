output "enabled" {
  description = "Whether or not this module is enabled"
  value       = "${var.enabled == "true" ? "Data Storage module enabled" : "Data Storage module not enabled"}"
}

output "dynamodb_enabled" {
  description = "Whether or not DynamoDB is enabled"
  value       = "${var.dynamodb_enabled == "true" ? "DynamoDB enabled" : "DynamoDB not enabled"}"
}

output "table_name" {
  description = "DynamoDB table name"
  value       = "${element(concat(aws_dynamodb_table.default.*.name, list("")), 0)}"
}

output "table_id" {
  description = "DynamoDB table ID"
  value       = "${element(concat(aws_dynamodb_table.default.*.id, list("")), 0)}"
}

output "table_arn" {
  description = "DynamoDB table ARN"
  value       = "${element(concat(aws_dynamodb_table.default.*.arn, list("")), 0)}"
}

output "global_secondary_index_names" {
  description = "DynamoDB secondary index names"
  value       = ["${null_resource.global_secondary_index_names.*.triggers.name}"]
}

output "local_secondary_index_names" {
  description = "DynamoDB local index names"
  value       = ["${null_resource.local_secondary_index_names.*.triggers.name}"]
}

output "table_stream_arn" {
  description = "DynamoDB table stream ARN"
  value       = "${element(concat(aws_dynamodb_table.default.*.stream_arn, list("")), 0)}"
}

output "table_stream_label" {
  description = "DynamoDB table stream label"
  value       = "${element(concat(aws_dynamodb_table.default.*.stream_label, list("")), 0)}"
}
