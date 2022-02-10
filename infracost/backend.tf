terraform {
  backend "remote" {
		organization = "fstoeber" # org name from step 2.
		workspaces {
			name = "finops-intro" # name for your app's state.
		}
	}
}
