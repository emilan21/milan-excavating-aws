# Change to milanexcavating.com ssl cert
resource "aws_acm_certificate" "milan_excavating_com_prod" {
  private_key       = file("namecheap_ssl/private.key")
  certificate_body  = file("namecheap_ssl/ericmilan_dev/ericmilan_dev.crt")
  certificate_chain = file("namecheap_ssl/ericmilan_dev/ericmilan_dev.ca-bundle")
}
