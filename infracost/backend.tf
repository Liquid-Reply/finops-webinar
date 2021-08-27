terraform {
  backend "http" {
    address = "https://gitlab.com/api/v4/projects/29054924/terraform/state/example-production"
    username = "gitlab-ci-token"
    password = "${CI_JOB_TOKEN}"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
