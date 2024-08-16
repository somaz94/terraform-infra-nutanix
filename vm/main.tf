# Target:
#   - terraform-test-vm-1

resource "nutanix_virtual_machine" "somaz_test02_master" {
  for_each = { for vm in local.control_plane_instances : vm.name => vm }

  name                 = each.value.name
  cluster_uuid         = data.nutanix_cluster.cluster.metadata.uuid
  num_sockets          = each.value.spec.cpu_sockets
  num_vcpus_per_socket = each.value.spec.cpu_cores_per_socket
  memory_size_mib      = each.value.spec.memory_size_gib * 1024

  guest_customization_cloud_init_user_data = base64encode(<<-EOF
    #cloud-config
    users:
      - name: somaz
        sudo: ALL=(ALL) NOPASSWD:ALL
        ssh-authorized-keys:
          - ${local.ssh_public_key}
        shell: /bin/bash
  EOF
  )

  disk_list {
    disk_size_mib         = each.value.spec.disk_size_gib * 1024 # GB
    data_source_reference = {
        kind = "image"
        uuid = data.nutanix_image.vm_base_image.id
      }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.main_subnet.id
    ip_endpoint_list {
      type = "ASSIGNED"
      ip   = format("%s.%s", local.ip_prefix, each.value.ip_suffix)
    }
  }

  timeouts {}
}

# Target:
#   - terraform-test-vm-2

resource "nutanix_virtual_machine" "somaz_test02_worker" {
  for_each = { for vm in local.worker_instance_group_1 : vm.name => vm }

  name                 = each.value.name
  cluster_uuid         = data.nutanix_cluster.cluster.metadata.uuid
  num_sockets          = each.value.spec.cpu_sockets
  num_vcpus_per_socket = each.value.spec.cpu_cores_per_socket
  memory_size_mib      = each.value.spec.memory_size_gib * 1024

  guest_customization_cloud_init_user_data = base64encode(<<-EOF
    #cloud-config
    users:
      - name: somaz
        sudo: ALL=(ALL) NOPASSWD:ALL
        ssh-authorized-keys:
          - ${local.ssh_public_key}
        shell: /bin/bash
  EOF
  )

  disk_list {
    disk_size_mib         = each.value.spec.disk_size_gib * 1024 # GB
    data_source_reference = {
        kind = "image"
        uuid = data.nutanix_image.vm_base_image.id
      }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.main_subnet.id
    ip_endpoint_list {
      type = "ASSIGNED"
      ip   = format("%s.%s", local.ip_prefix, each.value.ip_suffix)
    }
  }

  timeouts {}
}

