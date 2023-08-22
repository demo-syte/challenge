provider "aws" {
  region = var.REGION
}

#will save the state file to s3 bucket

terraform {
  backend "s3" {
    bucket = "dove-bucket"
    key    = "Terraform/backend"
    region = "us-east-1"
  }
}
