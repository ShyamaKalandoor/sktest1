provider "aws" {
  region = "us-west-2" # Change to your desired region
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket" # Change to your desired bucket name
  acl    = "public-read" # Grant public read access to the bucket

  tags = {
    Name = "example-bucket"
  }
}
