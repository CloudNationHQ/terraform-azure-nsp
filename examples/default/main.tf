module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.26"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "network_security_perimeter" {
  source = "../../"

  perimeter = {
    name                = "nsp-demo-dev"
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}
