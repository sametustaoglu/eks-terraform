provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # backend "s3" {
  #   bucket = var.bucket_name
  #   key    = "terraform.tfstate" #todo fatma create path like prod-test
  #   region = var.aws_region
  # }
}

