output "job_queue_arn" {
  description = "ARN of the created Batch Job Queue"
  value       = aws_batch_job_queue.batch_ce.arn
}

output "job_definition_arn" {
  description = "ARN of the created Batch Job Definition"
  value       = aws_batch_job_definition.batch_ce.arn
}

output "compute_environment_arn" {
  description = "ARN of the created Batch Compute Environment"
  value       = aws_batch_compute_environment.batch_ce.arn
}
