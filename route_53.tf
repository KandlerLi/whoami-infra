# resource "aws_route53_zone" "jkandler_de" {
#   name = "jkandler.de"
# }

# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.jkandler_de.zone_id
#   name    = "jkandler.de"
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.website_distribution.domain_name
#     zone_id                = aws_cloudfront_distribution.website_distribution.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# resource "aws_cloudfront_distribution" "website_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.whoami_ui.bucket_regional_domain_name
#     origin_id   = "S3-website"
#   }

#   enabled             = true
#   default_root_object = "index.html"
#   price_class         = "PriceClass_100"

#   default_cache_behavior {
#     target_origin_id = "S3-website"

#     viewer_protocol_policy = "redirect-to-https"
#     allowed_methods        = ["GET", "HEAD", "OPTIONS"]
#     cached_methods         = ["GET", "HEAD", "OPTIONS"]

#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl     = 0
#     default_ttl = 3600
#     max_ttl     = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     acm_certificate_arn = aws_acm_certificate.website_certificate.arn
#     ssl_support_method  = "sni-only"
#   }

#   depends_on = [aws_route53_record.website_certificate_validation]
# }

# resource "aws_acm_certificate" "website_certificate" {
#   domain_name       = "jkandler.de"
#   validation_method = "DNS"
# }

# resource "aws_route53_record" "website_certificate_validation" {
#   count = length(aws_acm_certificate.website_certificate.domain_validation_options)

#   name    = element(aws_acm_certificate.website_certificate.domain_validation_options.*.resource_record_name, count.index)
#   type    = element(aws_acm_certificate.website_certificate.domain_validation_options.*.resource_record_type, count.index)
#   zone_id = aws_route53_zone.jkandler_de.zone_id
#   records = [element(aws_acm_certificate.website_certificate.domain_validation_options.*.resource_record_value, count.index)]
#   ttl     = 60
# }

# resource "aws_acm_certificate_validation" "website_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.website_certificate.arn
#   validation_record_fqdns = aws_route53_record.website_certificate_validation.*.fqdn
# }
