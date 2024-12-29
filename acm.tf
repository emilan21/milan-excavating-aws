# Change to milanexcavating.com ssl cert
resource "aws_acm_certificate" "milan_excavating_com_prod" {
  private_key       = file("namecheap_ssl/private.key")
  certificate_body  = file("namecheap_ssl/milanexcavating_com.crt")
  certificate_chain = file("namecheap_ssl/milanexcavating_com.ca-bundle")
}
