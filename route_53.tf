resource "aws_route53_zone" "jkandler_de" {
  name = "jkandler.de"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.jkandler_de.zone_id
  name    = "www.jkandler.de"
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.config.website_endpoint
    zone_id                = aws_s3_bucket.whoami_ui.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.jkandler_de.zone_id
  name    = "jkandler.de"
  type    = "A"

  alias {
    name                   = "s3-website.eu-central-1.amazonaws.com" #aws_s3_bucket_website_configuration.config.website_endpoint
    zone_id                = aws_s3_bucket.whoami_ui.hosted_zone_id
    evaluate_target_health = true
  }
}
