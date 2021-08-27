terraform {
  backend "http" {
    address = "https://gitlab.com/api/v4/projects/29054924/terraform/state/example-production"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
