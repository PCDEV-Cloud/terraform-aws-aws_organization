data "aws_organizations_organization" "this" {}

data "aws_organizations_organizational_units" "level_1" {
  for_each  = local.data_level_0
  parent_id = each.value["id"]
}

data "aws_organizations_organizational_units" "level_2" {
  for_each  = local.data_level_1
  parent_id = each.value["id"]
}

data "aws_organizations_organizational_units" "level_3" {
  for_each  = local.data_level_2
  parent_id = each.value["id"]
}

data "aws_organizations_organizational_units" "level_4" {
  for_each  = local.data_level_3
  parent_id = each.value["id"]
}

data "aws_organizations_organizational_units" "level_5" {
  for_each  = local.data_level_4
  parent_id = each.value["id"]
}