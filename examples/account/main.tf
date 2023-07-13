provider "aws" {
  region = "eu-west-1"
}

data "aws_organizations_organization" "example" {}

module "account" {
  source = "../../modules/account"

  name  = "BillingToolingProd"
  email = "billing-tooling-prod@my-company.pl"
  ou_id = data.aws_organizations_organization.example.roots[0].id

  contact_information = {
    full_name      = "John Doe"
    phone_number   = "+48 654654654"
    company_name   = "My Company Inc."
    website_url    = "https://my-company.pl"
    address_line_1 = "Krakowskie Przedmieście 48/50"
    city           = "Warszawa"
    state          = "Mazowieckie"
    postal_code    = "00-071"
    country_code   = "PL"
  }

  alternate_contacts = {
    billing = {
      name          = "John Doe"
      title         = "CFO"
      email_address = "john.doe@my-company.pl"
      phone_number  = "+48 654654654"
    }

    operations = {
      name          = "John Doe"
      title         = "Operations Manager"
      email_address = "john.doe@my-company.pl"
      phone_number  = "+48 654654654"
    }

    security = {
      name          = "John Doe"
      title         = "Security Officer"
      email_address = "john.doe@my-company.pl"
      phone_number  = "+48 654654654"
    }
  }
}

output "account_id" {
  value = module.account.id
}

output "account_name" {
  value = module.account.name
}