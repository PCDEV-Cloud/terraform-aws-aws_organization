variable "organization_root_id" {
  type        = string
  default     = null
  description = "ID of the root of organization. If not provided, the ID of root of the default provider will be used."
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