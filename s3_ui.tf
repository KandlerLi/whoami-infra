resource "aws_s3_bucket" "whoami_ui" {
  bucket = var.domain
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


resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.whoami_ui.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.whoami_ui.arn}/*",
      "${aws_s3_bucket.whoami_ui.arn}",
    ]
  }
}

# resource "aws_s3_bucket_acl" "website" {
#   bucket = aws_s3_bucket.whoami_ui.id
#   acl    = "private"
# }
