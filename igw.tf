resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = var.ig_display_name
  vcn_id         = oci_core_vcn.vcn.id
}