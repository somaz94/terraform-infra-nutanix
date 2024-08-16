locals {
  subnet_name = "MAIN"

  ip_prefix     = "10.0.71"
  # vm_base_image = "Ubuntu Focal Server"
  vm_base_image = "ubuntu 22.04" # Settings -> Image Configuration
  ssh_public_key = file("~/.ssh/id_rsa_somaz.pub")

  control_plane_instances = [
    {
      name      = "terraform-test-vm-1"
      ip_suffix = 57
      spec = {
        cpu_sockets                              = 2
        cpu_cores_per_socket                     = 2
        memory_size_gib                          = 8
        disk_size_gib                            = 100
      }
    }
  ]

  worker_instance_group_1 = [
    {
      name      = "terraform-test-vm-2"
      ip_suffix = 58
      spec = {
        cpu_sockets                              = 2
        cpu_cores_per_socket                     = 2
        memory_size_gib                          = 16
        disk_size_gib                            = 100
      }
    }
  ]

}

