provider "aws" {
    region = "${var.aws_region}"
}

variable "aws_region" {
    description = "AWS region where to provision s3 bucket"
    default = "us-east-1"
}

variable "bucket_name" {
    description = "Name of the bucket"
    default = "default-bucket-name"
}

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}" 
}

resource "aws_s3_bucket_public_access_block" "block" {
    bucket = aws_s3_bucket.bucket.id

    block_public_acls   = true
    block_public_policy = true
    ignore_public_acls  = true
    restrict_public_buckets = true
}
