data "aws_caller_identity" "current" {}

resource "aws_kms_key" "lab" {
  description = "Customer-managed KMS key for Terraform learning lab"

  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  enable_key_rotation     = true
  rotation_period_in_days = 365

  deletion_window_in_days = 30

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableIAMPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })

  tags = {
    Project     = "terraform-aws-kms-lab"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}

resource "aws_kms_alias" "lab" {
  name          = "alias/terraform-kms-lab"
  target_key_id = aws_kms_key.lab.key_id
}
