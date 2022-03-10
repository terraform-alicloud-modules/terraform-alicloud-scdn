output "this_domain_name" {
  description = "The domain name."
  value       = module.scdn.this_domain_name
}

output "this_domain_status" {
  description = "The domain status."
  value       = module.scdn.this_domain_status
}

output "this_domain_config_ids" {
  description = "The id of list of domain configs."
  value       = module.scdn.this_domain_config_ids
}