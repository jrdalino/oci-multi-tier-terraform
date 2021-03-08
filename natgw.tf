resource "oci_core_nat_gateway" "natgw" {
  compartment_id = var.compartment_ocid
  display_name   = var.nat_gw_display_name
  vcn_id         = oci_core_vcn.vcn.id
}