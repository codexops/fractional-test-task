##########################################################################
# Default terraform backend configurations to store state at local
##########################################################################

terraform {
  backend "local" {}
}

##########################################################################
# Uncomment below code block and comment above code block to store
# terraform state remotely, ie. on Terraform Cloud, this will require 
# terraform account.
##########################################################################

# terraform {
#   backend "remote" {
#     organization = "fractional-task"
#     workspaces {
#       name = "terraform-fractional-task"
#     }
#   }
# }
