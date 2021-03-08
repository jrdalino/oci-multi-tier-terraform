resource "oci_core_subnet" "snpub" {
  cidr_block      = var.snpub_cidr_block
  display_name    = var.snpub_display_name
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.vcn.id
  dhcp_options_id = oci_core_vcn.vcn.default_dhcp_options_id
  route_table_id  = oci_core_route_table.rtpub.id
  dns_label       = var.snpub_dns_label

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "snpriv" {
  cidr_block                 = var.snpriv_cidr_block
  display_name               = var.snpriv_display_name
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.vcn.id
  dhcp_options_id            = oci_core_vcn.vcn.default_dhcp_options_id
  route_table_id             = oci_core_route_table.rtpriv.id
  prohibit_public_ip_on_vnic = true
  dns_label                  = var.snpriv_dns_label

  provisioner "local-exec" {
    command = "sleep 5"
  }
}