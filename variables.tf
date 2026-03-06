variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
  default     = "mywebsite-abcd-2024-12345"  # ← Use your own unique name
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
  default     = "./website"
}