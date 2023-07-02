data "aws_organizations_organization" "this" {}

################################################################################
# Account
################################################################################

locals {
  organization_root_id = data.aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_account" "this" {
  name                       = var.name
  email                      = var.email
  parent_id                  = coalesce(var.ou_id, local.organization_root_id)
  iam_user_access_to_billing = var.iam_user_access_to_billing ? "ALLOW" : "DENY"
  role_name                  = var.organization_account_access_role_name
  close_on_deletion          = var.close_on_deletion
  tags                       = var.tags

  lifecycle {
    ignore_changes = [role_name]
  }
}

################################################################################
# Primary Contact
################################################################################

resource "aws_account_primary_contact" "this" {
  count = var.contact_information != null ? 1 : 0

  account_id         = aws_organizations_account.this.id
  full_name          = var.contact_information.full_name
  phone_number       = var.contact_information.phone_number
  company_name       = var.contact_information.company_name
  website_url        = var.contact_information.website_url
  address_line_1     = var.contact_information.address_line_1
  address_line_2     = var.contact_information.address_line_2
  address_line_3     = var.contact_information.address_line_3
  city               = var.contact_information.city
  state_or_region    = var.contact_information.state
  postal_code        = var.contact_information.postal_code
  country_code       = var.contact_information.country_code
  district_or_county = var.contact_information.district_or_county
}

################################################################################
# Alternate Contacts
################################################################################

locals {
  alternate_contacts = tomap({ for i, k in var.alternate_contacts : i => merge(k, { alternate_contact_type = upper(i) }) })
}

resource "aws_account_alternate_contact" "this" {
  for_each = local.alternate_contacts

  account_id             = aws_organizations_account.this.id
  alternate_contact_type = each.value["alternate_contact_type"]
  name                   = each.value["name"]
  title                  = each.value["title"]
  email_address          = each.value["email_address"]
  phone_number           = each.value["phone_number"]
}