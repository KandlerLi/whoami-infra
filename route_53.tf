resource "aws_route53_zone" "jkandler_de" {
  name = "jkandler.de"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.jkandler_de.zone_id
  name    = "www.jkandler.de"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]

  alias {
    name                   = aws_s3_bucket.whoami_ui.website_endpoint
    zone_id                = aws_s3_bucket.whoami_ui.hosted_zone_id
    evaluate_target_health = true
  }
}
