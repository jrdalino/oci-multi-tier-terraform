resource "oci_core_instance" "webinstance1" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "web-server-1"
  shape               = "VM.Standard2.1"
  fault_domain        = "FAULT-DOMAIN-1"

  source_details {
    source_type             = "image"
    source_id               = "ocid1.image.oc1.phx.aaaaaaaauxxbnrkuwxll3t7tmra5cymdhhtdtmjduuagxfg2nicmmjykmumq" # https://docs.oracle.com/en-us/iaas/images/oraclelinux-6x/
    boot_volume_size_in_gbs = "50"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id = oci_core_subnet.snpub.id
    nsg_ids = [oci_core_network_security_group.webnsg.id]
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  timeouts {
    create = "60m"
  }
}

resource "oci_core_instance" "webinstance2" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "web-server-2"
  shape               = "VM.Standard2.1"
  fault_domain        = "FAULT-DOMAIN-2"

  source_details {
    source_type             = "image"
    source_id               = "ocid1.image.oc1.phx.aaaaaaaauxxbnrkuwxll3t7tmra5cymdhhtdtmjduuagxfg2nicmmjykmumq" # https://docs.oracle.com/en-us/iaas/images/oraclelinux-6x/
    boot_volume_size_in_gbs = "50"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id = oci_core_subnet.snpub.id
    nsg_ids = [oci_core_network_security_group.webnsg.id]
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  timeouts {
    create = "60m"
  }
}