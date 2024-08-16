provider "nutanix" {
  username = "admin"
  password = ""
  endpoint = "prism.somaz.link" # web url
}

terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "~>1.7.1"
    }
  }
}
