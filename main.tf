#create s3 bucket
resource "aws_s3_bucket" "myS3Bucket" {
  bucket = var.bucketname


#Optional
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
}

# OWNERSHIP OF BUCKET
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.myS3Bucket.id #Permission to owner only

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# TO MAKE BUCKET PUBLIC '''aws_s3_bucket_public_access_block''' Chnage the values to false
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.myS3Bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# APPLY ACL (PUBLIC READ)
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.myS3Bucket.id
  acl    = "public-read"
}

#INSERTING OBJECT IN BUCKET (FOR index.html)
resource "aws_s3_object" "index" {
  bucket     = aws_s3_bucket.myS3Bucket.id
  key        = "index.html"
  source     = "index.html"
  acl        = "public-read"
  content_type = "text/html"
  
}

#INSERTING OBJECT IN BUCKET (FOR error.html)
resource "aws_s3_object" "error" {
  bucket     = aws_s3_bucket.myS3Bucket.id
  key        = "error.html"
  source     = "error.html"
  acl        = "public-read"
  content_type = "text/html"
  
}

#INSERTING OBJECT IN BUCKET (FOR profile.jpg image)
resource "aws_s3_object" "profile" {
  bucket     = aws_s3_bucket.myS3Bucket.id
  key        = "profile.jpg"
  source     = "profile.jpg"
  acl        = "public-read"
  
}

#INSERTING OBJECT IN BUCKET (FOR your-photo.png image)
resource "aws_s3_object" "myprofile" {
  bucket     = aws_s3_bucket.myS3Bucket.id
  key        = "your-photo.png"
  source     = "your-photo.png"
  acl        = "public-read"
  
}

#CONFIGURE WEBSITE IN OUR TERRAFORM 
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.myS3Bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
    depends_on = [ aws_s3_bucket_acl.example ]
#   routing_rule {
#     condition {
#       key_prefix_equals = "docs/"
#     }
#     redirect {
#       replace_key_prefix_with = "documents/"
#     }
#   }
}