## Inputs

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

