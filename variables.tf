variable "organization_root_id" {
  type        = string
  default     = null
  description = "(Deprecated) ID of the root of organization. If not provided, the ID of root of the default provider will be used. Use the parent_id instead."
}

variable "parent_id" {
  type        = string
  default     = null
  description = "The ID of the parent OU where organizational units to be created. If not provided, the ID of root will be used."
}

variable "organizational_units" {
  type = list(object(
    # level 1
    {
      name = string
      tags = optional(map(string), {})
      children = optional(list(object(
        # level 2
        {
          name = string
          tags = optional(map(string), {})
          children = optional(list(object(
            # level 3
            {
              name = string
              tags = optional(map(string), {})
              children = optional(list(object(
                # level 4
                {
                  name = string
                  tags = optional(map(string), {})
                  children = optional(list(object(
                    # level 5
                    {
                      name = string
                      tags = optional(map(string), {})
                    }
                  )))
                }
              )))
            }
          )))
        }
      )))
    }
  ))
  description = "A list of Organizational Units with their children. Maximum nesting is limited to 5 levels."
}

variable "accounts" {
  type        = list(any)
  default     = []
  description = "A list of member accounts with settings."
}

variable "services" {
  type = object({
    account_management            = optional(bool, false)
    application_migration_service = optional(bool, false)
    artifact                      = optional(bool, false)
    audit_manager                 = optional(bool, false)
    backup                        = optional(bool, false)
    cloudformation_stacksets      = optional(bool, false)
    cloudtrail                    = optional(bool, false)
    compute_optimizer             = optional(bool, false)
    config                        = optional(bool, false)
    control_tower                 = optional(bool, false)
    detective                     = optional(bool, false)
    devops_guru                   = optional(bool, false)
    directory_service             = optional(bool, false)
    firewall_manager              = optional(bool, false)
    guardduty                     = optional(bool, false)
    health                        = optional(bool, false)
    access_analyzer               = optional(bool, false)
    inspector                     = optional(bool, false)
    license_manager               = optional(bool, false)
    macie                         = optional(bool, false)
    marketplace                   = optional(bool, false)
    network_manager               = optional(bool, false)
    resource_access_manager       = optional(bool, false)
    security_hub                  = optional(bool, false)
    s3_storage_lens               = optional(bool, false)
    security_lake                 = optional(bool, false)
    service_catalog               = optional(bool, false)
    service_quotas                = optional(bool, false)
    iam_identity_center           = optional(bool, false)
    systems_manager               = optional(bool, false)
    tag_policies                  = optional(bool, false)
    trusted_advisor               = optional(bool, false)
    well_architected_tool         = optional(bool, false)
    vpc_ip_address_manager        = optional(bool, false)
    vpc_reachability_analyzer     = optional(bool, false)
    all                           = optional(bool, false)
  })
  default = {}
}