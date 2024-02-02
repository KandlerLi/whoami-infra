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


resource "aws_s3_bucket" "state_file" {
  bucket = "kandler-li-test-bucket"
}
