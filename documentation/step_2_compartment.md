# Step 2: Create a Compartment
## Prepare Scripts
```
mkdir tf-compartment
cd tf-compartment
cp ../tf-provider/provider.tf .
vi compartment.tf
```
```
resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = "ocid1.tenancy.oc1..xxx"
    description = "Compartment for Terraform resources."
    name = "jrdalinoterraform"
}
```

## Add Outputs
```
vi outputs.tf
```
```
# Outputs for compartment

output "compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}

output "compartment-OCID" {
  value = oci_identity_compartment.tf-compartment.id
}
```

## Create Compartment
```
terraform init
terraform plan
terraform apply
```