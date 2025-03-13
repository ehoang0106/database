terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "terraform-state-khoa-hoang"
    key = "terraform-state-my-db"
    region = "us-west-1"
  }
}

provider "aws" {
  region = "us-west-1"
}

