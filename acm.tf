resource "aws_acm_certificate" "website_cert" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  provider          = aws.virginia
  lifecycle {
    create_before_destroy = true
  }
}
