provider "aws" {
  region = "eu-west-1"
}

module "organizational_units" {
  source = "../../modules/organizational_units"

  organizational_units = [
    {
      name = "Security"
      children = [
        { name = "Prod" },
        { name = "SDLC" }
      ]
    },
    {
      name = "Infrastructure"
      children = [
        { name = "Prod" },
        { name = "SDLC" }
      ]
    }
  ]
}

output "organizational_unit_ids" {
  value = module.organizational_units.ids
}

output "organizational_unit_names" {
  value = module.organizational_units.names
}