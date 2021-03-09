resource "oci_core_instance" "dbinstance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
  compartment_id      = var.compartment_ocid
  display_name        = "db-server"
  shape               = "VM.Standard2.1"
  fault_domain        = "FAULT-DOMAIN-1"

  source_details {
    source_type             = "image"
    source_id               = "ocid1.image.oc1.phx.aaaaaaaa45germv4cefdox4doioklz6lepe4auzr7ooaxyfn4tneikwzofsa" # https://docs.oracle.com/en-us/iaas/images/centos-8x/
    boot_volume_size_in_gbs = "50"
  }

  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.snpriv.id
    nsg_ids          = [oci_core_network_security_group.dbnsg.id]
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  timeouts {
    create = "60m"
  }
}