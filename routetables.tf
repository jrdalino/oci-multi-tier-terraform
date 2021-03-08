resource "oci_core_route_table" "rtpub" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = var.rtpub_display_name
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_route_table" "rtpriv" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = var.rtpriv_display_name
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.natgw.id
  }
}