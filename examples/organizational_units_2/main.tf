provider "aws" {
  region = "eu-west-1"
}

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

locals {
  data_list_of_level_0 = [for i in data.aws_organizations_organization.this.roots : { id = i.id, name = i.name, parent_path = null }]
  data_list_of_level_1 = flatten([for i in data.aws_organizations_organizational_units.level_1 : [for j in i.children : { id = j.id, name = j.name, parent_path = local.data_level_0[i.id].path }]])
  data_list_of_level_2 = flatten([for i in data.aws_organizations_organizational_units.level_2 : [for j in i.children : { id = j.id, name = j.name, parent_path = local.data_level_1[i.id].path }]])
  data_list_of_level_3 = flatten([for i in data.aws_organizations_organizational_units.level_3 : [for j in i.children : { id = j.id, name = j.name, parent_path = local.data_level_2[i.id].path }]])
  data_list_of_level_4 = flatten([for i in data.aws_organizations_organizational_units.level_4 : [for j in i.children : { id = j.id, name = j.name, parent_path = local.data_level_3[i.id].path }]])
  data_list_of_level_5 = flatten([for i in data.aws_organizations_organizational_units.level_5 : [for j in i.children : { id = j.id, name = j.name, parent_path = local.data_level_4[i.id].path }]])

  data_level_0 = { for i in local.data_list_of_level_0 : i.id => merge(i, { level = 0, path = "/" }) }
  data_level_1 = { for i in local.data_list_of_level_1 : i.id => merge(i, { level = 1, path = "/${i.name}" }) }
  data_level_2 = { for i in local.data_list_of_level_2 : i.id => merge(i, { level = 2, path = "${i.parent_path}/${i.name}" }) }
  data_level_3 = { for i in local.data_list_of_level_3 : i.id => merge(i, { level = 3, path = "${i.parent_path}/${i.name}" }) }
  data_level_4 = { for i in local.data_list_of_level_4 : i.id => merge(i, { level = 4, path = "${i.parent_path}/${i.name}" }) }
  data_level_5 = { for i in local.data_list_of_level_5 : i.id => merge(i, { level = 5, path = "${i.parent_path}/${i.name}" }) }

  data_list_of_organizational_units = concat(local.data_list_of_level_0, local.data_list_of_level_1, local.data_list_of_level_2, local.data_list_of_level_3, local.data_list_of_level_4, local.data_list_of_level_5)
  # data_organizational_units         = merge(local.data_level_0, local.data_level_1, local.data_level_2, local.data_level_3, local.data_level_4, local.data_level_5)
  data_organizational_units = { for i in merge(local.data_level_0, local.data_level_1, local.data_level_2, local.data_level_3, local.data_level_4, local.data_level_5) : i.path => i }
}

output "list_of_organizational_units" {
  value = local.data_list_of_organizational_units
}

output "organizational_units" {
  value = local.data_organizational_units
}
