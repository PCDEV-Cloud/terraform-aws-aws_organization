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
    },
    { name = "Projects" }
  ]
}