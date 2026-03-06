terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 module (without bucket policy)
module "s3_site" {
  source       = "./modules/s3_static_site"
  bucket_name  = var.bucket_name
  project_name = var.project_name
  environment  = var.environment
  website_path = var.website_path
}

# CloudFront module
module "cloudfront" {
  source                      = "./modules/cloudfront_distribution"
  project_name                = var.project_name
  environment                 = var.environment
  origin_bucket_id            = module.s3_site.bucket_id
  bucket_regional_domain_name = module.s3_site.bucket_regional_domain_name
}

# S3 Bucket Policy (after both modules exist)
resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = module.s3_site.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontOAC"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${module.s3_site.bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.distribution_arn
          }
        }
      }
    ]
  })
}