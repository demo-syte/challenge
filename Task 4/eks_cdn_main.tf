 ### Once this Terraform configuration is applied, it will:
 #### Set up an EKS cluster with worker nodes running in the specified subnets.
 #### Create a CloudFront distribution that uses the EKS cluster's endpoint as its origin.

provider "aws" {
  region = "us-west-2"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "blogapp-cluster"
  cluster_version = "1.21"
  subnets         = ["subnet-abcde012", "subnet-bcde012a", "subnet-cde012ab"] 

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "m5.large"
      key_name      = var.key_name
    }
  }
}

resource "aws_cloudfront_distribution" "blogapp_cdn" {
  origin {
    domain_name = module.eks.endpoint
    origin_id   = "blogappEKSOrigin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "blogappEKSOrigin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}
