# AWS Account Terraform module

## Usage

```hcl
module "aws_account" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_organization/modules/aws_account"

  name  = "My-AWS-account"
  email = "my-aws-account@pcdev.pl"
  ou_id = "<OU-ID-HERE>"

  contact_information = {
    full_name      = "John Doe"
    phone_number   = "+48 654654654"
    company_name   = "PCDEV"
    website_url    = "https://pcdev.pl"
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
      email_address = "john.doe@pcdev.pl"
      phone_number  = "+48 654654654"
    }
    
    operations = {
      name          = "John Doe"
      title         = "Operations Manager"
      email_address = "john.doe@pcdev.pl"
      phone_number  = "+48 654654654"
    }

    security = {
      name          = "John Doe"
      title         = "Security Officer"
      email_address = "john.doe@pcdev.pl"
      phone_number  = "+48 654654654"
    }
  }
}
```