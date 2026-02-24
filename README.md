# Terraform AWS Batch Job Module

This Terraform module configures and manages AWS Batch resources (Compute Environment, Job Queue, and Job Definition) using Fargate. It can also optionally create the required networking (VPC, Subnets) and IAM resources.

## Features

- Creates AWS Batch Compute Environment on Fargate.
- Creates Job Queues and Job Definitions.
- Supports creating from scratch or using existing resources (VPC, Subnets, Security Groups, and IAM roles) via the `create_resources` variable.
- Uses the official AWS VPC module (`terraform-aws-modules/vpc/aws`) for robust network creation.
- Supports applying tags to all created resources.

## Requirements

- Terraform >= 1.0
- AWS Provider >= 4.0

## Usage

```hcl
module "batch_job" {
  source = "github.com/Freakisimo/terraform-aws-batch-job"

  # Environment and prefix
  env   = "dev"
  model = "data-processor"

  # Networking and IAM (Create new resources)
  create_resources     = true
  vpc_name             = "my-batch-vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  main_sg              = "batch-security-group"

  # AWS Batch Fargate Configuration
  min_vcpu = 0
  max_vcpu = 4
  vcpu     = 1
  memory   = 2048
  image    = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-image:latest"

  # Tags
  tags = {
    Project     = "DataProcessing"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `env` | Environment name (e.g., dev, stg, prod) | `string` | n/a | Yes |
| `model` | Prefix name for the Batch resources to be created | `string` | n/a | Yes |
| `create_resources` | Flag to create resources (VPC, SG, IAM) if they do not exist | `bool` | `false` | No |
| `vpc_name` | Name of the VPC to use or create | `string` | n/a | Yes |
| `vpc_cidr` | CIDR block for the VPC if create_resources is true | `string` | `"10.0.0.0/16"` | No |
| `main_sg` | Name of the Security Group to create or search for | `string` | n/a | Yes |
| `public_subnet_cidrs` | List of public subnet CIDRs | `list(string)` | `[]` | No |
| `private_subnet_cidrs` | List of private subnet CIDRs | `list(string)` | `[]` | No |
| `min_vcpu` | The minimum amount of vCPU for the compute environment | `number` | n/a | Yes |
| `max_vcpu` | The maximum amount of vCPU for the compute environment | `number` | n/a | Yes |
| `vcpu` | The amount of vCPU to give to the ECS container | `number` | n/a | Yes |
| `memory` | The amount of memory (in MiB) to give to the ECS container | `number` | n/a | Yes |
| `image` | Docker image URL for the Batch job | `string` | n/a | Yes |
| `tags` | A map of tags to add to all resources | `map(string)` | `{}` | No |

## Outputs

| Name | Description |
|------|-------------|
| `job_queue_arn` | ARN of the created Batch Job Queue |
| `job_definition_arn` | ARN of the created Batch Job Definition |
| `compute_environment_arn` | ARN of the created Batch Compute Environment |

## Author

Created by Freakisimo.

## License

This project is licensed under the [MIT License](LICENSE).