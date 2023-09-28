# organizational_units

> [!IMPORTANT]
> Since version `v1.2.0`, variable `parent_id` is required.
> Review your code and complete the required variables before updating the module.

Creates organizational units (OU) in the AWS organization root or any other organizational unit.

## Usage

```hcl
module "aws_organizational_units" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_organization//modules/organizational_units"

  parent_id = "<OU-ID-HERE>"

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
}
```

## Examples

- [organizational-units](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/organizational-units) - Creates organizational units
