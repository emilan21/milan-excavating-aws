# Prod account
resource "aws_s3_bucket" "milan_excavating_com_prod" {
  bucket        = var.s3_name_prod
  force_destroy = true
}

resource "aws_s3_bucket_policy" "milan_excavating_com_prod" {
  bucket = aws_s3_bucket.milan_excavating_com_prod.id
  depends_on = [
    aws_s3_bucket_ownership_controls.milan_excavating_com_prod,
    aws_s3_bucket_public_access_block.milan_excavating_com_prod,
  ]
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.milan_excavating_com_prod.id}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "milan_excavating_com_prod" {
  bucket = aws_s3_bucket.milan_excavating_com_prod.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "milan_excavating_com_prod" {
  bucket = aws_s3_bucket.milan_excavating_com_prod.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "milan_excavating_com_prod" {
  bucket = aws_s3_bucket.milan_excavating_com_prod.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "milan_excavating_com_prod" {
  depends_on = [
    aws_s3_bucket_ownership_controls.milan_excavating_com_prod,
    aws_s3_bucket_public_access_block.milan_excavating_com_prod,
  ]

  bucket = aws_s3_bucket.milan_excavating_com_prod.id
  acl    = "private"
}
