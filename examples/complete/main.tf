provider "aws" {
  region = "eu-west-1"
}

module "aws_organization" {
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

  accounts = [
    {
      name                = "SecurityToolingProd"
      email               = "security-tooling-prod@my-company.pl"
      ou                  = "/Security/Prod"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "LogArchiveProd"
      email               = "log-archive-prod@my-company.pl"
      ou                  = "/Security/Prod"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "SecurityToolingTest"
      email               = "security-tooling-test@my-company.pl"
      ou                  = "/Security/SDLC"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "NetworkProd"
      email               = "network-prod@my-company.pl"
      ou                  = "/Infrastructure/Prod"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "SharedInfrServicesProd"
      email               = "shared-infr-services-prod@my-company.pl"
      ou                  = "/Infrastructure/Prod"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "NetworkTest"
      email               = "network-test@my-company.pl"
      ou                  = "/Infrastructure/SDLC"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "NetworkDev"
      email               = "network-dev@my-company.pl"
      ou                  = "/Infrastructure/SDLC"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    },
    {
      name                = "SharedInfrServicesTest"
      email               = "shared-infr-services-test@my-company.pl"
      ou                  = "/Infrastructure/SDLC"
      contact_information = local.contact_information
      alternate_contacts  = local.alternate_contacts
    }
  ]
}

locals {
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