
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "s3explorer-url" {
  value = "https://s3-${var.region}.amazonaws.com/${aws_s3_bucket.explorer.id}/index.html"
}