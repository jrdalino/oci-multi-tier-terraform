# WebSecurityGroup
resource "oci_core_network_security_group" "webnsg" {
  compartment_id = var.compartment_ocid
  display_name   = var.web_nsg_display_name
  vcn_id         = oci_core_vcn.vcn.id
}

# Rules related to WebSecurityGroup

# EGRESS
resource "oci_core_network_security_group_security_rule" "webnsgegress" {
  network_security_group_id = oci_core_network_security_group.webnsg.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS
resource "oci_core_network_security_group_security_rule" "webnsgingress" {
  network_security_group_id = oci_core_network_security_group.webnsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "webnsgingressssh" {
  network_security_group_id = oci_core_network_security_group.webnsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "219.74.0.0/16"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}

# DBSecurityGroup
resource "oci_core_network_security_group" "dbnsg" {
  compartment_id = var.compartment_ocid
  display_name   = var.db_nsg_display_name
  vcn_id         = oci_core_vcn.vcn.id
}

# Rules related to DBSecurityGroup

# EGRESS
resource "oci_core_network_security_group_security_rule" "dbnsgegress" {
  network_security_group_id = oci_core_network_security_group.dbnsg.id
  direction                 = "EGRESS"
  protocol                  = "6"
  #    destination = "10.0.0.0/16"
  destination      = "10.0.0.0/24"
  destination_type = "CIDR_BLOCK"
}

# INGRESS
resource "oci_core_network_security_group_security_rule" "dbnsgingress" {
  network_security_group_id = oci_core_network_security_group.dbnsg.id
  direction                 = "INGRESS"
  protocol                  = "6"
  #    source = "10.0.0.0/16"
  source      = "10.0.0.0/24"
  source_type = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 3306
      min = 3306
    }
  }
}