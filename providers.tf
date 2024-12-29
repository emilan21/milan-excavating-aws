terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.0"
    }
  }
}

# Configure the AWS Provider
# Change the profile
provider "aws" {
  region  = "us-east-1"
  profile = "Developer-585008089082"
}

# Configure the archive Provider
provider "archive" {
  alias = "prod"
}
