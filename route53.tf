locals {
  MXRecordSets = {
    "milanexcavating.com" = {
      Type = "MX",
      TTL  = 3600,
      MXRecords = [
        {
          "Value" = "10 mx1.privateemail.com"
        },
        {
          "Value" = "10 mx2.privateemail.com"
        }
      ]
    }
  }
  TXTRecordSets = {
    "milanexcavating.com" = {
      Type = "TXT",
      TTL  = 3600,
      TXTRecords = [
        {
          "Value" = "v=spf1 include:spf.privateemail.com ~all"
        }
      ]
    }
  }
}

resource "aws_route53_zone" "milan_excavating_com_prod" {
  name          = "milanexcavating.com"
  force_destroy = true
}

output "nameservers" {
  description = "Route 53 Name Servers"
  value       = aws_route53_zone.milan_excavating_com_prod.name_servers
}

resource "aws_route53_record" "milan_excavating_com_prod" {
  zone_id = aws_route53_zone.milan_excavating_com_prod.zone_id
  name    = "milanexcavating.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.milan_excavating_com_prod.domain_name
    zone_id                = aws_cloudfront_distribution.milan_excavating_com_prod.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "mx_records" {
  for_each = local.MXRecordSets
  zone_id  = aws_route53_zone.milan_excavating_com_prod.id
  name     = each.key
  type     = each.value.Type
  records  = [for key, record in each.value["MXRecords"] : record["Value"]]
  ttl      = 1
}

resource "aws_route53_record" "txt_records" {
  for_each = local.TXTRecordSets
  zone_id  = aws_route53_zone.milan_excavating_com_prod.id
  name     = each.key
  type     = each.value.Type
  records  = [for key, record in each.value["TXTRecords"] : record["Value"]]
  ttl      = 1
}
