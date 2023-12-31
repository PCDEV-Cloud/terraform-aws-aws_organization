variable "organization_root_id" {
  type        = string
  default     = null
  description = "(Deprecated) Use the 'parent_id' instead of this."
}

variable "parent_id" {
  type        = string
  description = "The ID of the parent OU where organizational units to be created."
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
                  )), [])
                }
              )), [])
            }
          )), [])
        }
      )), [])
    }
  ))
  description = "A list of Organizational Units with their children. Maximum nesting is limited to 5 levels."
}