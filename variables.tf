variable "config" {
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
    condition     = var.config.location != null || var.location != null
    error_message = "location must be provided either in the config object or as a separate variable."
  }

  validation {
    condition     = var.config.resource_group_name != null || var.resource_group_name != null
    error_message = "resource group name must be provided either in the config object or as a separate variable."
  }
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = {}
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
