# 🌐 Terraform Static Website — AWS S3 + CloudFront (Modular)

> Production-ready static website on AWS using reusable Terraform modules — scalable, secure, and follows industry best practices.

![Terraform](https://img.shields.io/badge/Terraform-1.0+-7B42BC?style=flat&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat&logo=amazonaws&logoColor=white)
![S3](https://img.shields.io/badge/S3-Storage-569A31?style=flat&logo=amazons3)
![CloudFront](https://img.shields.io/badge/CloudFront-CDN-FF9900?style=flat&logo=amazonaws)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat)

---

---

## About The Project

This project builds a complete static website hosting infrastructure on AWS using modular Terraform — each component is isolated, reusable, and independently manageable. Unlike the no-modules version, this approach follows real-world Terraform practices used in production environments.

The key challenge solved here is avoiding circular dependencies between S3 and CloudFront — the bucket policy is deliberately created in the root configuration after both modules are initialized.

---

## Architecture
```
Users
  │
  ▼
CloudFront Distribution  ←  HTTPS, OAC, Edge Caching
  │
  ▼
S3 Bucket (Private)      ←  Static Files Storage
```

All traffic flows through CloudFront. The S3 bucket has zero direct public access — secured via Origin Access Control (OAC).

---

## Module Structure
```
terraform-static-site-modules/
├── main.tf                        # Root config — orchestrates modules + bucket policy
├── variables.tf
├── outputs.tf
├── website/
│   ├── index.html
│   ├── error.html
│   └── style.css
└── modules/
    ├── s3_static_site/            # S3 bucket + website config + file uploads
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── cloudfront_distribution/   # CloudFront + OAC
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## Built With

- [Terraform](https://www.terraform.io/) v1.0+
- [AWS S3](https://aws.amazon.com/s3/)
- [AWS CloudFront](https://aws.amazon.com/cloudfront/)

---

## Getting Started

### Prerequisites

- AWS account with IAM permissions for S3 and CloudFront
- Terraform v1.0+
- AWS CLI configured

### Deployment
```bash
# 1. Clone the repo
git clone https://github.com/your-username/terraform-static-site-modules.git
cd terraform-static-site-modules

# 2. Update bucket name in variables.tf
bucket_name = "your-globally-unique-bucket-name"

# 3. Deploy
terraform init
terraform plan
terraform apply
```

> ⏱ CloudFront takes ~10–15 minutes to deploy globally.

---

## Outputs

After `terraform apply` completes:
```bash
s3_bucket_name             = "your-bucket-name"
cloudfront_distribution_id = "XXXXXXXXXXXXXX"
cloudfront_domain_name     = "xxxxxxxxxx.cloudfront.net"
website_url                = "https://xxxxxxxxxx.cloudfront.net"
```

Open the `website_url` in your browser — your site is live.

<img width="1920" height="973" alt="image" src="https://github.com/user-attachments/assets/23f394ad-2a95-45a9-b612-187e733febf8" />

---

## Verification — S3 Bucket

- Go to AWS Console → S3
- Find your bucket and confirm files are uploaded
<img width="1920" height="935" alt="image" src="https://github.com/user-attachments/assets/b0fed3ca-6f9f-490a-9f29-d06494c4c9d1" />

---

## Verification — CloudFront Distribution

- Go to AWS Console → CloudFront → Distributions
- Status should show **Deployed**
- Origin access should show **Origin access control settings (recommended)**
<img width="1920" height="962" alt="image" src="https://github.com/user-attachments/assets/9a0ee00c-a082-4627-ae5c-a1aa58e809ac" />

---

## Key Design Decisions

**Why OAC over OAI?**
Origin Access Control is the modern AWS-recommended replacement for the deprecated Origin Access Identity — it provides stronger security with SigV4 signing.

**Why is the bucket policy in root and not inside the S3 module?**
The bucket policy needs the CloudFront distribution ARN, and CloudFront needs the S3 bucket details. Putting the policy in root breaks this circular dependency cleanly.

---

## Roadmap

- [ ] Add custom domain with Route53 + ACM certificate
- [ ] Set up CI/CD pipeline with GitHub Actions
- [ ] Add CloudWatch monitoring and alerts
- [ ] Add WAF for enhanced security

---

## Related

- 📖 [Read the full blog post](https://codezaza.com/2026/03/05/deploy-static-website-aws-terraform-modules/)

---
