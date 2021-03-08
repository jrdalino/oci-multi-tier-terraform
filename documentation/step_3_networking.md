# Step 3: Create a Virtual Cloud Network
## Add Authentication
```
vi provider.tf
```
```
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
  region           = var.region
}
```

## Create Variables File
```
vi variables.tf
```
```
# General
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "region" {}
variable "compartment_ocid" {}

# VCN
variable "vcn_cidr_block" {}
variable "vcn_display_name" {}
variable "vcn_dns_label" {}

# Internet Gateway
variable "ig_display_name" {}

# NAT Gateway
variable "nat_gw_display_name" {}

# Route Tables
variable "rtpub_display_name" {}
variable "rtpriv_display_name" {}

# Subnets
variable "snpub_cidr_block" {}
variable "snpub_display_name" {}
variable "snpub_dns_label" {}
variable "snpriv_cidr_block" {}
variable "snpriv_display_name" {}
variable "snpriv_dns_label" {}

# NSG
variable "web_nsg_display_name" {}
variable "db_nsg_display_name" {}
```

## Create TF Variables file
```
vi terraform.tfvars
```
```
# General
tenancy_ocid     = "ocid1.tenancy.oc1..xxx"
user_ocid        = "ocid1.user.oc1..xx"
private_key_path = "$HOME/.oci/jrdalino.pem"
fingerprint      = "xxx"
region           = "us-phoenix-1"
compartment_ocid = "ocid1.compartment.oc1..xxx"

# VCN
vcn_cidr_block   = "10.0.0.0/16"
vcn_display_name = "web-app-vcn"
vcn_dns_label    = "tfexamplevcn"

# Internet Gateway
ig_display_name = "ig-gateway"

# NAT Gateway
nat_gw_display_name = "nat-gateway"

# Route Tables
rtpub_display_name  = "rt-table-pub"
rtpriv_display_name = "rt-table-priv"

# Subnets
snpub_cidr_block    = "10.0.0.0/24"
snpub_display_name  = "public-subnet"
snpub_dns_label     = "publicsubnet"
snpriv_cidr_block   = "10.0.1.0/24"
snpriv_display_name = "private-subnet"
snpriv_dns_label    = "privatesubnet"

# NSG
web_nsg_display_name = "web-nsg"
db_nsg_display_name  = "db-nsg"
```

## Create Data Sources Ex. Availability Domains
```
vi datasources.tf
```
```
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}
```

## Create Virtual Cloud Network
```
vi vcn.tf
```
```
resource "oci_core_vcn" "vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
}
```

## Create Internet Gateway to allow public internet traffic
```
vi igw.tf
```
```
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = var.ig_display_name
  vcn_id         = oci_core_vcn.vcn.id
}
```

## Create NAT Gateway
```
vi natgw.tf
```
```
resource "oci_core_nat_gateway" "natgw" {
  compartment_id = var.compartment_ocid
  display_name   = var.nat_gw_display_name
  vcn_id         = oci_core_vcn.vcn.id
}
```

## Create Route Tables
```
vi routetables.tf
```
```
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
```

## Add Subnets
```
vi subnets.tf
```
```
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
```

## Create NSG
```
vi nsg.tf
```
```
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
```

## Add Outputs
```
vi outputs.tf
```
```
// TODO
```

## Provision the Resources using Terraform
```
terraform init
terraform plan
terraform apply
```