resource "oci_core_instance" "natinstance1" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "nat-server-1"
  shape               = "VM.Standard2.1"
  fault_domain        = "FAULT-DOMAIN-1"

  source_details {
    source_type             = "image"
    source_id               = "ocid1.image.oc1.phx.aaaaaaaaykn4jrvc7z742odk6c5ilyzoijju6zzvtm2nn5w7i6pwqwnub74a" # https://docs.oracle.com/en-us/iaas/images/image/9972c2ab-8d57-4ce0-9e5b-680cd56f61d4/
    boot_volume_size_in_gbs = "50"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.snpub.id
    nsg_ids          = [oci_core_network_security_group.webnsg.id]
    private_ip       = "10.0.0.2"    
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  timeouts {
    create = "60m"
  }
}

resource "oci_core_instance" "natinstance2" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "nat-server-2"
  shape               = "VM.Standard2.1"
  fault_domain        = "FAULT-DOMAIN-2"

  source_details {
    source_type             = "image"
    source_id               = "ocid1.image.oc1.phx.aaaaaaaaykn4jrvc7z742odk6c5ilyzoijju6zzvtm2nn5w7i6pwqwnub74a" # https://docs.oracle.com/en-us/iaas/images/image/9972c2ab-8d57-4ce0-9e5b-680cd56f61d4/
    boot_volume_size_in_gbs = "50"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.snpub.id
    nsg_ids          = [oci_core_network_security_group.webnsg.id]
    private_ip       = "10.0.0.3"
    skip_source_dest_check = true
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  timeouts {
    create = "60m"
  }
}