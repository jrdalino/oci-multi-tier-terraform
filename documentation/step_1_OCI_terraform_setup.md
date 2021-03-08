# Step 1: Set Up OCI Terraform
## Prepare
- Install Terraform
- Create RSA Keys
```
mkdir $HOME/.oci
openssl genrsa -out $HOME/.oci/jrdalino.pem 2048
chmod 600 $HOME/.oci/jrdalino.pem
openssl rsa -pubout -in $HOME/.oci/jrdalino.pem -out $HOME/.oci/jrdalino_public.pem
cat $HOME/.oci/jrdalino_public.pem
```
- Add List Policies
- Gather Required Information
```
[DEFAULT]
user=ocid1.user.oc1..xxx
fingerprint=xxx
tenancy=ocid1.tenancy.oc1..xxx
region=us-phoenix-1
key_file=$HOME/.oci/jrdalino.pem
```
- Create Configuration File
```
vi ~/.oci/config
```
```
[DEFAULT]
user=ocid1.user.oc1..xxx
fingerprint=xxx
tenancy=ocid1.tenancy.oc1..xxx
region=us-phoenix-1
key_file=/Users/jose.dalino/.oci/jrdalino.pem
```

## Add Provider
```
mkdir tf-provider
cd tf-provider
vi provider.tf
```
```
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..xxx"
  user_ocid = "ocid1.user.oc1..xxx" 
  private_key_path = "$HOME/.oci/jrdalino.pem"
  fingerprint = "xxx"
  region = "us-phoenix-1"
}
```

## Add Availability Domains
```
vi availability-domains.tf
```
```
# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains

# <tenancy-ocid> is the compartment OCID for the root compartment.
# Use <tenancy-ocid> for the compartment OCID.

data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..xxx"
}
```

## Add Outputs
```
vi outputs.tf
```
```
# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
```

## Run Scripts
```
terraform init
ls -a
terraform plan
terraform apply
```