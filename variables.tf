variable "region" {
  type    = string
  default = "us-east-1"
}

# Change accountId
variable "accountId" {
  type    = string
  default = 585008089082
}

variable "s3_name_prod" {
  type    = string
  default = "milan-excavating-com-prod"
}

variable "stage_name" {
  type    = string
  default = "milan_excavating_com_prod"
}

variable "domain" {
  type    = string
  default = "milanexcavating.com"
}
