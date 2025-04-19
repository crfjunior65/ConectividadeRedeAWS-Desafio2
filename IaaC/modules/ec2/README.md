<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.ec2_bia_dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.amazon_linux_2023](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu_linux_2204](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amis"></a> [amis](#input\_amis) | n/a | `map(any)` | <pre>{<br>  "Ubnt-us-east-1": "ami-0261755bbcb8c4a84",<br>  "Ubnt-us-east-2": "ami-0430580de6244e02e"<br>}</pre> | no |
| <a name="input_app_count"></a> [app\_count](#input\_app\_count) | n/a | `number` | `2` | no |
| <a name="input_autor"></a> [autor](#input\_autor) | Autor de edição. | `string` | n/a | yes |
| <a name="input_cdirs_acesso_remoto"></a> [cdirs\_acesso\_remoto](#input\_cdirs\_acesso\_remoto) | n/a | `list(any)` | <pre>[<br>  "187.180.212.28/32",<br>  "200.181.118.98/32"<br>]</pre> | no |
| <a name="input_cliente"></a> [cliente](#input\_cliente) | Cliente do projeto. | `string` | n/a | yes |
| <a name="input_dynamic_scaling"></a> [dynamic\_scaling](#input\_dynamic\_scaling) | Enable/disable dynamic scaling of the auto scaling group. | `bool` | `false` | no |
| <a name="input_dynamic_scaling_adjustment"></a> [dynamic\_scaling\_adjustment](#input\_dynamic\_scaling\_adjustment) | The adjustment in number of instances for dynamic scaling. | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment; will be prefixed to all resources. | `string` | `"Projeto"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"aws-key-terraform"` | no |
| <a name="input_projeto"></a> [projeto](#input\_projeto) | Descrição do projeto. | `string` | n/a | yes |
| <a name="input_regiao"></a> [regiao](#input\_regiao) | Região onde a infraestrutura será criada. | `string` | n/a | yes |
| <a name="input_shortnameid"></a> [shortnameid](#input\_shortnameid) | Nome curto para identificação dos recursos na AWS | `string` | n/a | yes |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | Name of the User. | `list(string)` | <pre>[<br>  "XXX",<br>  "YYY",<br>  "ZZZ"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->