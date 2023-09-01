provider "aws" {
  region = "eu-west-1"
}

module "organizational_units" {
  source = "../../modules/organizational_units"

  parent_id = "ou-o47f-o652tsyv"

  organizational_units = [
    {
      name = "InternalProject"
      children = [
        { name = "Staging" },
        { name = "UAT" },
        { name = "Production" }
      ]
    }
  ]
}