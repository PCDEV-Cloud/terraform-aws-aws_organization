output "organizational_unit_ids" {
  value       = module.organizational_units.ids
  description = "A map of Organizational Unit IDs."
}

output "organizational_unit_names" {
  value       = module.organizational_units.names
  description = "A map of Organizational Unit names."
}

output "account_ids" {
  value       = { for i, k in module.account : k.name => k.id }
  description = "A map of member account IDs."
}

output "account_names" {
  value       = [for i, k in module.account : k.name]
  description = "A list of member account names."
}