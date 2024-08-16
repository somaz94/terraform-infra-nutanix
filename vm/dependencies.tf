data "nutanix_cluster" "cluster" {
  name = "Somaz-HCI-Cluster" # Cluster Details -> Cluster Name
}

data "nutanix_image" "vm_base_image" {
  image_name = local.vm_base_image
}

data "nutanix_subnet" "main_subnet" {
  subnet_name = local.subnet_name
}

