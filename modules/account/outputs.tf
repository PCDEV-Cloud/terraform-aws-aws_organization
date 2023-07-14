output "id" {
  value       = aws_organizations_account.this.id
  description = "The member account ID."
}

output "name" {
  value       = aws_organizations_account.this.name
  description = "The member account name."
}