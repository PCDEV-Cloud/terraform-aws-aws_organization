# AWS Organization Terraform module

## Requirements
1. AWS organization must be created. For details on creating AWS organization, see [Creating and configuring an organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tutorials_basic.html#tutorial-orgs-step1) tutorial.
2. AWS Account Management service must be enabled. Read more in the [Using AWS Organizations with other AWS services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) guide.

## Features
1. Create member accounts in AWS organization.
2. Set primary and alternate contacts on member accounts.
3. Create organizational units (OU).

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

## Examples

- [complete](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/complete) - Creates a set of organizational units and member accounts
- [account](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/account) - Creates a member account
- [organizational-units-in-root](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/organizational-units-in-root) - Creates organizational units in the root of AWS organization
- [organizational-units-in-parent-ou](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/organizational-units-in-parent-ou) - Creates organizational units within another organizational unit