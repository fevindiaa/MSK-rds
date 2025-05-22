terraform {
  backend "s3" {
    bucket = "terraformstatee"
    key    = "msk/${var.env}/terraform.tfstate"
    region = "eu-north-1"
  }
}
