output "s3_bucket_name" {
  value       = module.s3_site.bucket_name
  description = "Name of the S3 bucket"
}

output "bucket_id" {
  value       = module.s3_site.bucket_id
  description = "S3 bucket ID"
}

output "cloudfront_distribution_id" {
  value       = module.cloudfront.distribution_id
  description = "CloudFront distribution ID"
}

output "cloudfront_domain_name" {
  value       = module.cloudfront.domain_name
  description = "CloudFront distribution domain"
}

output "website_url" {
  value       = "https://${module.cloudfront.domain_name}"
  description = "Full website URL via CloudFront"
}