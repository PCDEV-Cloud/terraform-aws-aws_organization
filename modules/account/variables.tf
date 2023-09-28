################################################################################
# Account
################################################################################

variable "name" {
  type        = string
  description = "Name for the member account."

  validation {
    condition     = can(regex("^[\\w]{1}([\\w\\s/_-]{0,1}[\\w]{1}){1,31}$", var.name))
    error_message = "The account name must consist of characters in the ranges [0-9a-zA-Z/_-] and whitespaces. It must start and end with an alphanumeric characters. It cannot contain two consecutive characters in the range [/_-] and whitespaces."
  }
}

variable "email" {
  type        = string
  description = "Email address to assign to the new member account. Email address must be unique, not already associated with another account."
}

variable "ou_id" {
  type        = string
  default     = null
  description = "(Deprecated) Use the 'parent_id' instead of this."
}

variable "parent_id" {
  type        = string
  description = "The ID of the parent OU where the member account is to be created."
}


variable "iam_user_access_to_billing" {
  type        = bool
  default     = true
  description = "If true, the new account enables IAM users and roles to access account billing information."
}

variable "organization_account_access_role_name" {
  type        = string
  default     = "OrganizationAccountAccessRole"
  description = "The name of an IAM role that organization automatically preconfigures in the new member account."
}

variable "close_on_deletion" {
  type        = bool
  default     = true
  description = "If true, a deletion event will close the account. If set to false, it will only remove from organization."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Key-value map of resource tags."
}

################################################################################
# Primary Contact
################################################################################

variable "contact_information" {
  type = object(
    {
      full_name          = string
      phone_number       = string
      company_name       = optional(string, null)
      website_url        = optional(string, null)
      address_line_1     = string
      address_line_2     = optional(string, null)
      address_line_3     = optional(string, null)
      city               = string
      state              = optional(string, null)
      postal_code        = string
      country_code       = string
      district_or_county = optional(string, null)
    }
  )
  default     = null
  description = "Sets the specified primary contact information associated with the account."
}

################################################################################
# Alternate Contacts
################################################################################

variable "alternate_contacts" {
  type = map(object(
    {
      name          = string
      title         = string
      email_address = string
      phone_number  = string
    }
  ))
  default     = {}
  description = "Sets the specified alternate contacts attached to the account. It allows to set up a billing, operations and security contacts."

  validation {
    condition     = alltrue([for i, k in var.alternate_contacts : contains(["billing", "operations", "security"], i)])
    error_message = "Invalid name for alternate contact. The object must be named 'billing', 'operations' or 'security'."
  }
}