locals {
  accounts = { for i in var.accounts : i.name => i }
}
