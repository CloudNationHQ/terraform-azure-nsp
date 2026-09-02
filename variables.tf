variable "perimeter" {
  description = "contains all network security perimeter configuration"
  type = object({
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

  validation {
    condition     = lookup(var.perimeter, "location", null) != null || var.location != null
    error_message = "location must be set on var.perimeter.location or on the module-level var.location."
  }

  validation {
    condition     = lookup(var.perimeter, "resource_group_name", null) != null || var.resource_group_name != null
    error_message = "resource_group_name must be set on var.perimeter.resource_group_name or on the module-level var.resource_group_name."
  }
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
