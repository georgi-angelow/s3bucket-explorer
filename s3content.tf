
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "content" {
  bucket = "s3-content-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["HEAD","GET","POST","PUT","DELETE"]
    allowed_origins = ["https://s3.amazonaws.com","https://s3.${var.region}.amazonaws.com","https://s3-${var.region}.amazonaws.com"]
    expose_headers  = ["ETag","x-amz-meta-custom-header","x-amz-server-side-encryption","x-amz-request-id","x-amz-id-2","date"]
    max_age_seconds = 3000
  }

  tags = {
    Name        = "s3-content"
    Environment = "Dev"
  }
}