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

  data_organizational_units = merge(local.data_level_0, local.data_level_1, local.data_level_2, local.data_level_3, local.data_level_4, local.data_level_5)

  parent_id  = local.data_organizational_units[var.parent_id].id
  parent_lvl = local.data_organizational_units[local.parent_id].level

  organizational_units = [for i in var.organizational_units : { name = i.name, children = try(i.children, []), parent_path = local.data_organizational_units[local.parent_id].path }]

  from_ou_list_of_level_1 = local.parent_lvl == 0 ? local.organizational_units : []
  from_ou_list_of_level_2 = local.parent_lvl == 1 ? local.organizational_units : []
  from_ou_list_of_level_3 = local.parent_lvl == 2 ? local.organizational_units : []
  from_ou_list_of_level_4 = local.parent_lvl == 3 ? local.organizational_units : []
  from_ou_list_of_level_5 = local.parent_lvl == 4 ? local.organizational_units : []

  from_root_list_of_level_1 = local.parent_lvl == 0 ? [] : flatten([for i in local.list_of_level_0 : [for j in i.children : { name = j.name, children = try(j.children, []), parent_path = "/" }]])
  from_root_list_of_level_2 = local.parent_lvl == 1 ? [] : flatten([for i in local.list_of_level_1 : [for j in i.children : { name = j.name, children = try(j.children, []), parent_path = "/${i.name}" }]])
  from_root_list_of_level_3 = local.parent_lvl == 2 ? [] : flatten([for i in local.list_of_level_2 : [for j in i.children : { name = j.name, children = try(j.children, []), parent_path = "${i.parent_path}/${i.name}" }]])
  from_root_list_of_level_4 = local.parent_lvl == 3 ? [] : flatten([for i in local.list_of_level_3 : [for j in i.children : { name = j.name, children = try(j.children, []), parent_path = "${i.parent_path}/${i.name}" }]])
  from_root_list_of_level_5 = local.parent_lvl == 4 ? [] : flatten([for i in local.list_of_level_4 : [for j in i.children : { name = j.name, children = try(j.children, []), parent_path = "${i.parent_path}/${i.name}" }]])

  list_of_level_0 = local.parent_lvl == 0 ? local.organizational_units : []
  list_of_level_1 = concat(local.from_ou_list_of_level_1, local.from_root_list_of_level_1)
  list_of_level_2 = concat(local.from_ou_list_of_level_2, local.from_root_list_of_level_2)
  list_of_level_3 = concat(local.from_ou_list_of_level_3, local.from_root_list_of_level_3)
  list_of_level_4 = concat(local.from_ou_list_of_level_4, local.from_root_list_of_level_4)
  list_of_level_5 = concat(local.from_ou_list_of_level_5, local.from_root_list_of_level_5)

  level_1 = { for i in local.list_of_level_1 : "/${i.name}" => { name = i.name, parent_id = local.parent_lvl == 0 ? local.parent_id : data.aws_organizations_organization.this.roots[0].id, tags = try(i.tags, {}) } }
  level_2 = { for i in local.list_of_level_2 : "${i.parent_path}/${i.name}" => { name = i.name, parent_id = local.parent_lvl == 1 ? local.parent_id : aws_organizations_organizational_unit.level_1[i.parent_path].id, tags = try(i.tags, {}) } }
  level_3 = { for i in local.list_of_level_3 : "${i.parent_path}/${i.name}" => { name = i.name, parent_id = local.parent_lvl == 2 ? local.parent_id : aws_organizations_organizational_unit.level_2[i.parent_path].id, tags = try(i.tags, {}) } }
  level_4 = { for i in local.list_of_level_4 : "${i.parent_path}/${i.name}" => { name = i.name, parent_id = local.parent_lvl == 3 ? local.parent_id : aws_organizations_organizational_unit.level_3[i.parent_path].id, tags = try(i.tags, {}) } }
  level_5 = { for i in local.list_of_level_5 : "${i.parent_path}/${i.name}" => { name = i.name, parent_id = local.parent_lvl == 4 ? local.parent_id : aws_organizations_organizational_unit.level_4[i.parent_path].id, tags = try(i.tags, {}) } }
}