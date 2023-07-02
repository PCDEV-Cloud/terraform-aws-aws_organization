output "ids" {
  value = merge(
    { "/" = data.aws_organizations_organization.this.roots[0].id },
    { for name, ou in aws_organizations_organizational_unit.level_1 : name => ou.id },
    { for name, ou in aws_organizations_organizational_unit.level_2 : name => ou.id },
    { for name, ou in aws_organizations_organizational_unit.level_3 : name => ou.id },
    { for name, ou in aws_organizations_organizational_unit.level_4 : name => ou.id },
    { for name, ou in aws_organizations_organizational_unit.level_5 : name => ou.id }
  )
  description = "description"
}