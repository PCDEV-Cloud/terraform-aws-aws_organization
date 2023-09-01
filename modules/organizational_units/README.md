# organizational_units

Creates organizational units (OU) in the AWS organization root or any other organizational unit.

## Usage

```hcl
module "aws_organizational_units" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_organization//modules/organizational_units"

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

- [organizational-units-in-root](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/organizational-units-in-root) - Creates organizational units in the root of AWS organization
- [organizational-units-in-parent-ou](https://github.com/PCDEV-Cloud/terraform-aws-aws_organization/tree/main/examples/organizational-units-in-parent-ou) - Creates organizational units within another organizational unit