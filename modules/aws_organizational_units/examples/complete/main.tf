provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-1"
}

module "aws_organizational_units" {
  source = "../../"

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