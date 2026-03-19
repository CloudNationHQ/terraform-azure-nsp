module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.26"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 4.0"

  storage = {
    name                = module.naming.storage_account.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "network_security_perimeter" {
  source = "../../"

  config = {
    name                = "nsp-demo-dev"
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    profiles = {
      default-profile = {
        access_rules = {
          allow-inbound-cidrs = {
            direction        = "Inbound"
            address_prefixes = ["203.0.113.0/24"]
          }
          allow-outbound-fqdns = {
            direction = "Outbound"
            fqdns     = ["example.com"]
          }
        }
        associations = {
          storage-assoc = {
            access_mode = "Learning"
            resource_id = module.storage.account.id
          }
        }
      }
    }
  }
}
