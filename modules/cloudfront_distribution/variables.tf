variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "static-website"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "production"
}

variable "origin_bucket_id" {
  description = "S3 bucket ID to use as CloudFront origin"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "S3 bucket regional domain name"
  type        = string
}