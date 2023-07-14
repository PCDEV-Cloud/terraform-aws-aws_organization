# organizational_units

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