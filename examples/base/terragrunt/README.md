# Terraform DynamoDB Module Base Terragrunt Example
A simple Terragrunt implementation using the Terraform DynamoDB module

The base example has autoscaling enabled but does not add any additional
DynamoDB attributes, [local secondary
index](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LSI.html)
maps or [global secondary
index](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LSI.html)
maps.

## Configuration
The Terragrunt implmentation uses a Terraform
[local](https://www.terraform.io/docs/backends/types/local.html) backend which
stores state on the local filesystem. This is configured in the `terraform.tf`
file. To use the default "s3" backend you can set the backend to "s3" in this
file. You will need to use `terragrunt plan --terragrunt-source-update` to force
a change to the backend'

Providers are configured in the `providers.tf` file, which sets approriate
versions to meet the module requirements.

Toggles are set in the `toogles.auto.tfvars` file. This file enables toggling
the whole module, DynamoDB resources and Autoscaling resources.

The module configuration used in `terraform.tfvars`
```
namespace                    = "lic"
stage                        = "dev"
name                         = "cluster"
hash_key                     = "HashKey"
range_key                    = "RangeKey"
autoscale_write_target       = 50
autoscale_read_target        = 50
autoscale_min_read_capacity  = 5
autoscale_max_read_capacity  = 20
autoscale_min_read_capacity  = 5
autoscale_max_write_capacity = 20
```

## Running The Example
Check out this module and switch to this directory.

Ensure the depedencies are installed
```
terragrunt init
```

Run a plan
```
terragrunt plan
```

Apply the plan
```
terragrunt apply
```

Destroy the resources
```
terragrunt destroy
```
