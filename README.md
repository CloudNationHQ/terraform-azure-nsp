# Network Security Perimeter

This terraform module simplifies the process of creating and managing network security perimeters on azure with customizable options and features, offering a flexible and powerful solution for managing azure network security perimeters through code.

## Features

Offers support for profiles, access rules, and associations.

Enables inbound and outbound access rules with support for address prefixes, FQDNs, service tags, and subscription IDs.

Supports resource associations with configurable access modes.

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_network_security_perimeter.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_perimeter) (resource)
- [azurerm_network_security_perimeter_access_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_perimeter_access_rule) (resource)
- [azurerm_network_security_perimeter_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_perimeter_association) (resource)
- [azurerm_network_security_perimeter_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_perimeter_profile) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_config"></a> [config](#input\_config)

Description: n/a

Type:

```hcl
object({
    name                = string
    resource_group_name = optional(string)
    location            = optional(string)
    tags                = optional(map(string))
    profiles = optional(map(object({
      name = optional(string)
      access_rules = optional(map(object({
        address_prefixes = optional(list(string))
        direction        = string
        fqdns            = optional(list(string))
        name             = optional(string)
        service_tags     = optional(list(string))
        subscription_ids = optional(list(string))
      })), {})
      associations = optional(map(object({
        access_mode = string
        name        = optional(string)
        resource_id = string
      })), {})
    })), {})
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `{}`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_network_security_perimeter"></a> [network\_security\_perimeter](#output\_network\_security\_perimeter)

Description: contains all exported attributes of the network security perimeter

### <a name="output_profiles"></a> [profiles](#output\_profiles)

Description: contains all exported attributes of the network security perimeter profile
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-nsp/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-nsp" />
</a>

## License

MIT Licensed. See [LICENSE](https://github.com/cloudnationhq/terraform-azure-nsp/blob/main/LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/private-link/network-security-perimeter-concepts)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/networkperimeter/)
