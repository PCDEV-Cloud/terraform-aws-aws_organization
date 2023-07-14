output "ids" {
  value = merge(
    { "/" = data.aws_organizations_organization.this.roots[0].id },
    { for i, k in aws_organizations_organizational_unit.level_1 : i => k.id },
    { for i, k in aws_organizations_organizational_unit.level_2 : i => k.id },
    { for i, k in aws_organizations_organizational_unit.level_3 : i => k.id },
    { for i, k in aws_organizations_organizational_unit.level_4 : i => k.id },
    { for i, k in aws_organizations_organizational_unit.level_5 : i => k.id }
  )
  description = "A map of Organizational Unit IDs."
}

output "names" {
  value = merge(
    { "/" = data.aws_organizations_organization.this.roots[0].name },
    { for i, k in aws_organizations_organizational_unit.level_1 : i => k.name },
    { for i, k in aws_organizations_organizational_unit.level_2 : i => k.name },
    { for i, k in aws_organizations_organizational_unit.level_3 : i => k.name },
    { for i, k in aws_organizations_organizational_unit.level_4 : i => k.name },
    { for i, k in aws_organizations_organizational_unit.level_5 : i => k.name }
  )
  description = "A map of Organizational Unit names."
}