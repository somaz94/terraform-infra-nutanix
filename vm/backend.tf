# terraform {
#   backend "gcs" {
#     bucket = "hci_tfstate"
#     prefix = "tf/somaz"
#   }
# }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}