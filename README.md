# Terraform AWS Batch Job Module

This Terraform module configures and manages resources related to AWS Batch jobs.

## Requirements

- Terraform >= 1.0
- AWS Provider >= 3.0

## Usage

```hcl
module "batch_job" {
  source = "github.com/your-repo/terraform-aws-batch-job"

  # Define the required variables
  env              = "dev"
  create_resources = true
  model            = "example-model"
  main_sg          = "sg-12345678"
  vpc_name         = "example-vpc"
  min_vcpu         = 1
  max_vcpu         = 4
  vcpu             = 2
  memory           = 2048
  image            = "example-image-url"
}
```

## Variables

| Name              | Description                                                   | Type     | Default  | Required |
|-------------------|---------------------------------------------------------------|----------|----------|----------|
| `env`             | Environment name                                              | `string` | n/a      | Yes      |
| `create_resources`| Flag to create resources if they do not exist                 | `bool`   | `false`  | No       |
| `model`           | Prefix for the resource to be created                         | `string` | n/a      | Yes      |
| `main_sg`         | Security group ID                                             | `string` | n/a      | Yes      |
| `vpc_name`        | Name of the VPC                                               | `string` | n/a      | Yes      |
| `min_vcpu`        | Minimum amount of vCPU for the ECS instance                   | `number` | n/a      | Yes      |
| `max_vcpu`        | Maximum amount of vCPU for the ECS instance                   | `number` | n/a      | Yes      |
| `vcpu`            | Amount of vCPU for the ECS instance                           | `number` | n/a      | Yes      |
| `memory`          | Amount of memory for the ECS instance                         | `number` | n/a      | Yes      |
| `image`           | URL of the container image                                    | `string` | n/a      | Yes      |

## Outputs

| Name              | Description                                                   |
|-------------------|---------------------------------------------------------------|
| `job_id`          | ID of the created job                                         |
| `job_status`      | Status of the job                                             |

## Author

Created by Freakisimo.

## License

This project is licensed under the [MIT License](LICENSE).