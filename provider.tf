provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "DevOps-Foundations"
      Environment = "Demo"
      ManagedBy   = "Isaac"
    }
  }
}