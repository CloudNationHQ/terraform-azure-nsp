output "network_security_perimeter" {
  description = "contains all exported attributes of the network security perimeter"
  value       = azurerm_network_security_perimeter.this
}

output "profiles" {
  description = "contains all exported attributes of the network security perimeter profile"
  value       = azurerm_network_security_perimeter_profile.this
}
