variable "env" {
  type        = string
  description = "description"
}

variable "create_resources" {
  type        = bool
  description = "Flag to create resources if they do not exist"
  default     = false
}

variable "model" {
  type        = string
  description = "The prefix of the resource to be created"
}

variable "main_sg" {
  type        = string
  description = "description"
}

variable "vpc_name" {
  type        = string
  description = "description"
}

variable "min_vcpu" {
  type        = number
  description = "The amount of cpu to give to the ECS instance."
}

variable "max_vcpu" {
  type        = number
  description = "The amount of cpu to give to the ECS instance."
}

variable "vcpu" {
  type        = number
  description = "The amount of ecs memory to give to the ECS instance."
}

variable "memory" {
  type        = number
  description = "The amount of ecs memory to give to the ECS instance."
}

variable "image" {
  description = "image URL"
  type        = string
}