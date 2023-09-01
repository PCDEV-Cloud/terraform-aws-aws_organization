# account

Creates member account in AWS organization and sets primary and alternate contacts.

## Usage

```hcl
module "aws_account" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_organization//modules/account"

  name  = "BillingToolingProd"
  email = "billing-tooling-prod@my-company.pl"
  ou_id = "<OU-ID-HERE>"

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
```

## Examples

- [account](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/account) - Creates a member account