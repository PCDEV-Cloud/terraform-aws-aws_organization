resource "aws_organizations_organization" "this" {
  count = length(local.services) > 0 ? 1 : 0

  aws_service_access_principals = local.services
  feature_set                   = "ALL"
}

module "organizational_units" {
  source = "./modules/organizational_units"

  organization_root_id = var.organization_root_id
  organizational_units = var.organizational_units
}

module "account" {
  source   = "./modules/account"
  for_each = local.accounts

  name  = each.value["name"]
  email = each.value["email"]
  ou_id = can(each.value["ou"]) ? module.organizational_units.ids["${each.value["ou"]}"] : null

  iam_user_access_to_billing            = try(each.value["iam_user_access_to_billing"], false)
  organization_account_access_role_name = try(each.value["organization_account_access_role_name"], null)
  close_on_deletion                     = try(each.value["close_on_deletion"], true)
  contact_information                   = try(each.value["contact_information"], null)
  alternate_contacts                    = try(each.value["alternate_contacts"], {})
  tags                                  = try(each.value["tags"], null)

  depends_on = [
    module.organizational_units
  ]
}