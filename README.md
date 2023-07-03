# AWS Organization Terraform module

## Usage

```hcl
module "aws_organization" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_organization"

  organizational_units = [
    {
      name = "Security"
      children = [
        { name = "Prod" },
        { name = "SDLC" }
      ]
    }
  ]

  accounts = [
    {
      name  = "SecurityToolingProd"
      email = "security-tooling-prod@my-company.pl"
      ou    = "/Security/Prod"

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
    },
    {
      name  = "SecurityToolingTest"
      email = "security-tooling-test@my-company.pl"
      ou    = "/Security/SDLC"
    }
  ]
}
```