# Terraform DynamoDB Module

Terraform module to provision a [DynamoDB](https://aws.amazon.com/dynamodb/) table with autoscaling.

[Autoscaler](./modules/dynamodb_autoscaler) scales up/down the provisioned OPS for the DynamoDB table based on the load.

## Requirements
This module requires Terraform version `~> 0.11` to run.

This module requires the following provider version:
* [AWS Provider](https://github.com/terraform-providers/terraform-provider-aws) `>= 2.6.0`
* [null Provider](https://github.com/terraform-providers/terraform-provider-null) `>= 2.1.0`

## Architectural Decisions Register (ADR's)
All decisions about this service are recorded as ADR's and are stored in the repo. View the [TOC](doc/adr/README.md)

## Usage

```hcl
module "dynamodb_table" {
  source                       = "git::https://github.com/lic-nz/terraform-dynamodb-module.git?ref=master"
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
```

## Advanced Usage

With additional attributes, global secondary indexes and `non_key_attributes` (see [examples/complete](examples/complete)).

```hcl
module "dynamodb_table" {
  source                       = "git::https://github.com/lic-nz/terraform-dynamodb-module.git?ref=master"
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

  dynamodb_attributes = [
    {
      name = "DailyAverage"
      type = "N"
    },
    {
      name = "HighWater"
      type = "N"
    },
  ]

  local_secondary_index_map = [
  {
    name      = "TimestampSortIndex"
    range_key = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  },
  {
    name      = "HighWaterIndex"
    range_key = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

  global_secondary_index_map = [
    {
      name               = "DailyAverageIndex"
      hash_key           = "DailyAverage"
      range_key          = "HighWater"
      write_capacity     = 5
      read_capacity      = 5
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
    {
      name            = "HighWaterIndex"
      hash_key        = "HighWater"
      write_capacity  = 5
      read_capacity   = 5
      projection_type = "KEYS_ONLY"
    },
  ]
}
```

## Examples
Some base and complete example implementations of module usage can be found in
the [examples](./examples) folder. There are examples for implementation using
both Terraform and Terragrunt.

## Inputs

**IMPORTANT INFORMATION**: Please see [billing-mode](#billing-mode) for advice on choosing
the appropriate option for `billing_mode` when using this module.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (e.g `policy` or `role`) | list | `<list>` | no |
| autoscale\_max\_read\_capacity | DynamoDB autoscaling max read capacity | string | `20` | no |
| autoscale\_max\_write\_capacity | DynamoDB autoscaling max write capacity | string | `20` | no |
| autoscale\_min\_read\_capacity | DynamoDB autoscaling min read capacity | string | `5` | no |
| autoscale\_min\_write\_capacity | DynamoDB autoscaling min write capacity | string | `5` | no |
| autoscale\_read\_target | The target value (in %) for DynamoDB read autoscaling | string | `50` | no |
| autoscale\_write\_target | The target value (in %) for DynamoDB write autoscaling | string | `50` | no |
| aws\_region | AWS region where resources will be created | string | `ap-southeast-2` | no |
| billing\_mode | DynamoDB Billing mode. Can be PROVISIONED or PAY_PER_REQUEST | string | `PROVISIONED` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| dynamodb\_attributes | Additional DynamoDB attributes in the form of a list of mapped values | list | `<list>` | no |
| dynamodb\_enabled | Whether or not to enable DynamoDB resources | string | `false` | no |
| enable\_autoscaler | Whether or not to enable DynamoDB autoscaling | string | `true` | no |
| enable\_encryption | Enable DynamoDB server-side encryption | string | `true` | no |
| enable\_point\_in\_time\_recovery | Enable DynamoDB point in time recovery | string | `true` | no |
| enable\_streams | Enable DynamoDB streams | string | `false` | no |
| enabled | Whether or not the module should create any resources | string | `true` | no |
| global\_secondary\_index\_map | Additional global secondary indexes in the form of a list of mapped values | list | `<list>` | no |
| hash\_key | DynamoDB table Hash Key | string | - | yes |
| hash\_key\_type | Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | string | `S` | no |
| local\_secondary\_index\_map | Additional local secondary indexes in the form of a list of mapped values | list | `<list>` | no |
| name | Name (e.g. `app` or `cluster`) | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | - | yes |
| range\_key | DynamoDB table Range Key | string | `` | no |
| range\_key\_type | Range Key type, which must be a scalar type: `S`, `N` or `B` for (S)tring, (N)umber or (B)inary data | string | `S` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`, `infra`) | string | - | yes |
| stream\_view\_type | When an item in a table is modified, what information is written to the stream | string | `` | no |
| tags | Additional tags (e.g map(`BusinessUnit`,`XYX`) | map | `<map>` | no |
| ttl\_attribute | DynamoDB table ttl attribute | string | `Expires` | no |
| ttl\_enabled | Whether ttl is enabled or disabled | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb\_enabled | Whether or not DynamoDB is enabled |
| enabled | Whether or not this module is enabled |
| global\_secondary\_index\_names | DynamoDB secondary index names |
| local\_secondary\_index\_names | DynamoDB local index names |
| table\_id | DynamoDB table ID |
| table\_name | DynamoDB table name |
| table\_stream\_arn | DynamoDB table stream ARN |
| table\_stream\_label | DynamoDB table stream label |

## Billing Mode

The choice of PROVISIONED or PAY_PER_REQUEST billing, is largely financial, but also may be influenced by limiting latency, development time spent on right sizing, and the risk of paying for unexpectedly high loads.

As at May 2019 PAY_PER_REQUEST costs about 7x as much per request than PROVISIONED, which means that any DynamoDB Table that can achieve more than 14.4% average utilization with provisioned capacity will cost less dollars using PROVISIONED capacity. Note that:
* Low utilization in dev, and accp environments and configuring each environment identically will mean PROVISIONED capacity is less attractive. 
* The minimum provisioned capacity is 1 read and 1 write per second which may make PAY_PER_REQUEST more attractive for lightly used tables, even tif they have predicatable load.
* Using auto scaling for PROVISIONED capacity will help to increase the utilization of tables that require more than the minimum capacity.

WIth regards to limitting latency, both choices can be problematic in different situations. Rapid bursts of traffic to either PAY_PER_REQUEST or autoscaled PROVISIONED tables will mean some requests are throttled. However if this is an issue internet commentary suggests that PAY_PER_REQUEST scales smoothly up to 4000 requests/sec so this might be a good starting point for comparison.

PAY_PER_REQUEST has a clear advantage in terms of development time spent on right sizing until very heavy loads are encountered where latency due to autoscaling is an issue.

PAY_PER_REQUEST does have the risk of generating unexpectedly large bills if something happens to cause unexpectedly high demand. This can be managed in several ways, such as configuring alarms when traffic is unexpectedly high.
