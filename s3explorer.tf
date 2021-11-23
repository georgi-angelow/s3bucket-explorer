resource "aws_s3_bucket" "explorer" {
  bucket = "s3-explorer-bucket-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  tags = {
    Name        = "s3-explorer-bucket-${data.aws_caller_identity.current.account_id}"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.explorer.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "S3ExplorerGetMinimal"
    Statement = [
      {
        Sid       = "S3ExplorerGetMinimal"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${aws_s3_bucket.explorer.arn}/index.html",
          "${aws_s3_bucket.explorer.arn}/explorer.css",
          "${aws_s3_bucket.explorer.arn}/explorer.js",
        ]
      },
    ]
  })
}
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.explorer.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"

  etag = filemd5("index.html")
}
resource "aws_s3_bucket_object" "explorerjs" {
  bucket = aws_s3_bucket.explorer.id
  key    = "explorer.js"
  source = "explorer.js"

  etag = filemd5("explorer.js")
}
resource "aws_s3_bucket_object" "explorercss" {
  bucket = aws_s3_bucket.explorer.id
  key    = "explorer.css"
  source = "explorer.css"

  etag = filemd5("explorer.css")
}