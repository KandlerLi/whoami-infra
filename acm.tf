resource "aws_acm_certificate" "website_cert" {
  domain_name       = var.domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
