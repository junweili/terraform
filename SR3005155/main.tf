
provider "aws" {
    region = "${var.aws_region}"
}

variable "aws_region" {
    description = "AWS region where to provision s3 bucket"
    default = "us-east-1"
}

variable "bucket_name" {
    description = "Name of the bucket"
    default = "examplebucket"
}

variable "replication" {
    default = false
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "vmware-bucket-aas-${var.bucket_name}"

}

resource "aws_s3_bucket" "crr_bucket" {
    count  = var.replication ? 1 : 0
    bucket = "vmware-bucket-aas-${var.bucket_name}-copy"
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_acl" "crr_bucket_acl" {
  count  = var.replication ? 1 : 0
  bucket = aws_s3_bucket.crr_bucket[0].id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_versioning" "crr_bucket_versioning" {
  count  = var.replication ? 1 : 0
  bucket = aws_s3_bucket.crr_bucket[0].id
  versioning_configuration {
    status = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  count  = var.replication ? 1 : 0
  #depends_on = [aws_s3_bucket_versioning.s3_bucket_versioning]

  role   = "arn:aws:iam::216400275809:role/E2ES3FullAccess"
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id = "vmware-bucket-aas-${var.bucket_name}-crr"

    filter {
      prefix = ""
    }

    priority = 0

    status = "Enabled"

    destination {
      bucket = aws_s3_bucket.crr_bucket[0].arn
    }

    source_selection_criteria {
      replica_modifications {
        status = "Enabled"
      }
      sse_kms_encrypted_objects {
        status = "Disabled"
      }
    }
  }
}

