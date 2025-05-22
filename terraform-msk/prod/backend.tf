terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key    = "msk/${var.env}/terraform.tfstate"
    region = "eu-north-1"
  }
}