terraform {
  backend "s3" {
    bucket = "alau-bucket"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}
