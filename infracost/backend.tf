terraform {
  backend "remote" {
		organization = "fstoeber" # org name from step 2.
		workspaces {
			name = "finops-intro" # name for your app's state.
		}
	}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
