terraform {
  backend "s3" {
    bucket = "terraform-state-narendra"
    key    = "terraform/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
