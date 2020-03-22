# terraform-aws-icon-prep-basic

## Features

All in one module to deploy a P-Rep node for ICON. Best called from [github.com/insight-infrastructure/terragrunt-aws-icon](github.com/insight-infrastructure/terragrunt-aws-icon) as there are a lot of variables you need to fill in and you need to reference a playbook in [github.com/insight-infrastructure/ansible-icon-prep](github.com/insight-infrastructure/terragrunt-aws-icon). 

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-aws-icon-prep-basic"
    keystore_password = "testing1."
    keystore_path = "${path.cwd}/../../testing/fixtures/keystore"
    main_ip = aws_eip.this.public_ip
    network_name = "testnet"
    private_key_path = var.private_key_path
    public_key_path = var.public_key_path
    playbook_file_path = var.playbook_file_path 
}
```
## Examples

- [defaults](https://github.com/robc-io/terraform-aws-icon-prep-basic/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ami\_id | n/a | `string` | `""` | no |
| consul\_enabled | n/a | `bool` | `false` | no |
| corporate\_ip | n/a | `string` | `""` | no |
| create\_eip | n/a | `bool` | `false` | no |
| ebs\_volume\_size | n/a | `number` | `200` | no |
| eip\_id | n/a | `string` | `""` | no |
| instance\_type | n/a | `string` | `"m5.large"` | no |
| keystore\_password | n/a | `string` | n/a | yes |
| keystore\_path | n/a | `string` | n/a | yes |
| main\_ip | n/a | `string` | n/a | yes |
| monitoring | n/a | `bool` | `true` | no |
| name | n/a | `string` | `"prep"` | no |
| network\_name | n/a | `string` | n/a | yes |
| node\_type | n/a | `string` | `"prep"` | no |
| playbook\_file\_path | n/a | `string` | n/a | yes |
| playbook\_vars | n/a | `map(string)` | `{}` | no |
| private\_key\_path | n/a | `string` | n/a | yes |
| prometheus\_enabled | n/a | `bool` | `false` | no |
| public\_key\_path | n/a | `string` | n/a | yes |
| roles\_dir | n/a | `string` | `"."` | no |
| root\_volume\_size | n/a | `number` | `25` | no |
| ssh\_user | n/a | `string` | `"ubuntu"` | no |
| subnet\_id | n/a | `string` | `""` | no |
| tags | n/a | `map(string)` | `{}` | no |
| user\_data | n/a | `string` | `""` | no |
| volume\_path | n/a | `string` | `"/dev/xvdf"` | no |
| vpc\_security\_group\_ids | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| ip | n/a |
| public\_ip | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [robc-io](github.com/robc-io)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.