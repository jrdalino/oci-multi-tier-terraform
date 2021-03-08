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