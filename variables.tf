variable "env" {
  type        = string
  description = "Environment name (e.g., dev, stg, prod)"
}

variable "create_resources" {
  type        = bool
  description = "Flag to create resources (VPC, SG, IAM) if they do not exist"
  default     = false
}

variable "model" {
  type        = string
  description = "The prefix name for the Batch resources to be created"
}

variable "main_sg" {
  type        = string
  description = "Name of the Security Group"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC to use or create"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC if create_resources is true"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"
  default     = []
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDRs"
  default     = []
}

variable "min_vcpu" {
  type        = number
  description = "The minimum amount of vCPU for the compute environment"
}

variable "max_vcpu" {
  type        = number
  description = "The maximum amount of vCPU for the compute environment"
}

variable "vcpu" {
  type        = number
  description = "The amount of vCPU to give to the ECS container."
}

variable "memory" {
  type        = number
  description = "The amount of memory (in MiB) to give to the ECS container."
}

variable "image" {
  description = "Docker image URL for the Batch job"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}