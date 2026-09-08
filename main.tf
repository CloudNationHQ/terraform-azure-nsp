resource "azurerm_network_security_perimeter" "this" {
  resource_group_name = coalesce(
    var.network_security_perimeter.resource_group_name, var.resource_group_name
  )

  location = coalesce(
    var.network_security_perimeter.location, var.location
  )

  tags = coalesce(
    var.network_security_perimeter.tags, var.tags
  )

  name = var.network_security_perimeter.name
}

resource "azurerm_network_security_perimeter_profile" "this" {
  for_each = var.network_security_perimeter.profiles

  name = coalesce(
    each.value.name, each.key
  )

  network_security_perimeter_id = azurerm_network_security_perimeter.this.id
}

resource "azurerm_network_security_perimeter_access_rule" "this" {
  for_each = merge([
    for profiles_key, profiles in var.network_security_perimeter.profiles : {
      for rules_key, rules in profiles.access_rules :
      "${profiles_key}.${rules_key}" => merge(rules, { profiles_key = profiles_key })
    }
  ]...)

  name = coalesce(
    each.value.name, element(split(".", each.key), 1)
  )

  network_security_perimeter_profile_id = azurerm_network_security_perimeter_profile.this[each.value.profiles_key].id
  address_prefixes                      = each.value.address_prefixes
  direction                             = each.value.direction
  fqdns                                 = each.value.fqdns
  service_tags                          = each.value.service_tags
  subscription_ids                      = each.value.subscription_ids
}

resource "azurerm_network_security_perimeter_association" "this" {
  for_each = merge([
    for profiles_key, profiles in var.network_security_perimeter.profiles : {
      for associations_key, associations in profiles.associations :
      "${profiles_key}.${associations_key}" => merge(associations, { profiles_key = profiles_key })
    }
  ]...)

  name = coalesce(
    each.value.name, element(split(".", each.key), 1)
  )

  network_security_perimeter_profile_id = azurerm_network_security_perimeter_profile.this[each.value.profiles_key].id
  access_mode                           = each.value.access_mode
  resource_id                           = each.value.resource_id
}
