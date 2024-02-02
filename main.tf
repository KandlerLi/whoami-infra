terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      CreatedBy = "terraform"
      Project   = "whoami-infra"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "kandler-li-tf-state"
    key            = "whoami-infra"
    dynamodb_table = "kandler-li-tf-lock"
  }
}

resource "aws_s3_bucket" "whoami_ui" {
  bucket = "kandler-li-whoami-ui"
}

resource "aws_s3_bucket_website_configuration" "config" {
  bucket = aws_s3_bucket.whoami_ui.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}


resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.whoami_ui.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
