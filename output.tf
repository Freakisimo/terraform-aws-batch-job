output "job_id" {
  description = "ID of the created job"
  value       = aws_batch_job.job.id // Replace with the actual resource reference
}

output "job_status" {
  description = "Status of the job"
  value       = aws_batch_job.job.status // Replace with the actual resource reference
}
