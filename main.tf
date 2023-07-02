module "aws_organizational_units" {
  source = "./modules/aws_organizational_units"

  organization_root_id = var.organization_root_id
  organizational_units = var.organizational_units
}

module "aws_account" {
  source   = "./modules/aws_account"
  for_each = local.accounts

  name  = each.value["name"]
  email = each.value["email"]
  # ou_id = lookup(module.aws_organizational_units.ids, try(each.value["ou"], ""), null)

  ou_id = can(each.value["ou"]) ? module.aws_organizational_units.ids["${each.value["ou"]}"] : null

  # iam_user_access_to_billing            = lookup(each.values, "iam_user_access_to_billing", true)
  # organization_account_access_role_name = lookup(each.values, "organization_account_access_role_name", "OrganizationAccountAccessRole")
  # contact_information = lookup(each.value, "contact_information", null)
  # alternate_contacts  = lookup(each.value, "alternate_contacts", {})
  # tags = {}

  depends_on = [
    module.aws_organizational_units
  ]
}