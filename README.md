# oci-multi-tier-terraform

## ASSIGNMENT #1: Provision multi-tier environment on OCI
- 1) Please create 2 web server VM on 2 different FD - FD1 & FD2 Running OL6 and install apache http port 80. Security: Web VM will have internet connection (port 80). Shape of the VM: 1 OCPU
- 2) Please create another VM on AD3 running mysql 5.7 on CentOS 6 w/. Security: MySQL VM only has connection to web VM. MySQL VM should not have public IP address. Shape of the VM: 1 OCPU

## ASSIGNMENT #2: You need to create 2 NAT/Firewall High availability Pair VM and 1 Private VM as below diagram
- Please use pacemaker and corosync to have HA (failover) of NAT instance

## Architecture Diagram
![Image description](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/architecture-diagram.png)

## Steps
- [Step 1: Setup OCI terraform](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/step_1_OCI_terraform_setup.md) 
- [Step 2: Create Compartment](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/step_2_compartment.md)
- [Step 3: Setup Networking](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/step_3_networking.md)
- [Step 4: Setup Database - IN PROGESS](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/step_4_database.md)
- [Step 5: Setup Web Servers - IN PROGESS](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/step_5_web_server.md)
- [Step 6: Setup NAT Instance HA Pair - IN PROGESS](https://github.com/jrdalino/oci-multi-tier-terraform/blob/main/documentation/step_6_nat_instance_ha_pair.md)

## References
- Oracle Cloud Infra Foundations: https://learn.oracle.com/ols/course/oracle-cloud-infrastructure-foundations/35644/75250
- Terraform OCI Provider Docs: https://registry.terraform.io/providers/hashicorp/oci/latest/docs
- Terraform > Set Up OCI Terraform: https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm
- Terraform > Create a Compartment: https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-compartment/01-summary.htm
- Terraform > Create a Compute Instance: https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-compute/01-summary.htm
- Terraform > Craete a Virtual Cloud Network: https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-vcn/01-summary.htm
- Oracle 3-Tier Solution: https://docs.oracle.com/en/solutions/autoscale-webapp/index.html#GUID-BA16E194-D871-4A39-8385-1CE4A8E6565D
- OCI Compute Overview: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Concepts/computeoverview.htm
- NAT Gateway: https://docs.oracle.com/en/learn/nat_gateway_private_compute_instance/index.html#introduction
- NAT Intance Config: https://www.oracle.com/a/ocom/docs/nat-instance-configuration.pdf
- OCI VIP Auto Failover: https://medium.com/oracledevs/automatic-virtual-ip-failover-on-oracle-cloud-infrastructure-ce28dc293b04
- Pacemaker & Corosync: https://www.ateam-oracle.com/isv-implementation-details-part-4a-linux-clustering-with-pacemaker-and-corosync