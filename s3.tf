resource "aws_s3_bucket" "fxlinkdefault01" {
bucket = var.bucket_name
acl = "private"
tags = {
  "Name" = "Fxlink_bucket1"
  Environment = "${var.Environment[0]}"
    }
}
resource "aws_s3_bucket_public_access_block" "fxlinkdefault01" {
  bucket = aws_s3_bucket.fxlinkdefault01.id

  block_public_acls   = true
  block_public_policy = true
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id      = aws_vpc.Main.id
  service_name = "com.amazonaws.us-east-1.s3"
  #todo- Security group
  tags = { 
        "Name" = "s3-vpc-endpoint"
         }
}
resource "aws_vpc_endpoint_route_table_association" "S3_RT" {
    route_table_id = aws_route_table.Fxlink_Private1_RT.id
    vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
