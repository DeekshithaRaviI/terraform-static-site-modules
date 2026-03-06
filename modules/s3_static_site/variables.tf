variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "static-website"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "website_path" {
  description = "Path to local website files"
  type        = string
}