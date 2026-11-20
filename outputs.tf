output "kms_key_id" {
  description = "KMS key ID after deployment."
  value       = aws_kms_key.lab.key_id
}

output "kms_key_arn" {
  description = "KMS key ARN after deployment."
  value       = aws_kms_key.lab.arn
}

output "kms_alias_name" {
  description = "Planned KMS alias."
  value       = aws_kms_alias.lab.name
}
