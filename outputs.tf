# SSH Keys
output "generated_ssh_private_key" {
  value = tls_private_key.public_private_key_pair.private_key_pem
}

# VCN
# output "oci_core_vcn_cidr_block" {
#   value       = oci_core_vcn.vcn.cidr_block
#   description = "Deprecated. The first CIDR IP address from cidrBlocks. Example: 172.16.0.0/16"
# }

# Internet Gateway

# NAT Gateway

# Route Tables

# Subnets

# NSG