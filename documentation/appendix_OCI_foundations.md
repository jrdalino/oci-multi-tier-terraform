# OCI Foundations

### Cloud Concepts: https://csrc.nist.gov/publications/detail/sp/800-145/final
#### Cloud Computing
- On-demand self-service
- Broad network access
- Resource pooling
- Rapid Elasticity
- Measured Service
#### Service Models
- Traditional Models vs
- Infrastructure as a service vs 
- Platform as a service vs
- Software as a service
#### Cloud Terminology
- High Availability
- Disaster Recovery RPO vs RTO
- Fault Tolerance
- Scalability: Vertical, Horizonal
- Elasticity
#### CAPEX vs OPEX
- Capital Expenditure
- Operational Expenditure

### OCI Architecture
#### OCI Regions
- Region > Availabily Domain (AD) > Fault Domain (FD)
- One AD Region
- Choosing a Region: Location, Data Residency & Compliance, Service Availability
#### Availability Domains
- Isolated from each other
- Do not share physical infrastructure, such as power, cooling, internal availability
#### Fault Domains
- Each AD as three FD
- Act as a logical data center within an AD
- Do not share SPOF (same physical server, physical rack, switch, power distribution)
#### High Availability Design
- Fault Domain: Protection against failure within an AD
- Availability Domain: Protection from entire AD failure (multi-AD region)
- Region Pair: Protection from disaster with data residency & compliance
#### Compartments
- Logical Design Construct for Isolation and control
- Each resource belong to a single compartment
- Resources can interact with other resources in different compartments
- Resources and compartments can be added and deleted anytime
- Resrouces can be moved from one compartment to another
- Resources from multiple regions can be in the same compartment
- Compartments can be nested (six levels deep)
- You can give a group of users access to compartments by writing Policies
- Analyze cost and assign budget for resources in compartments

### OCI Networking Services
#### Virtual Cloud Network
- Software defined private network that you set up in OCI
- Enables OCI resources such as compute instances to securely communicate with internet, other instances or on-premise data centers
- Lives in an OCI region
- Highly Available, Scalable and Secure
- VCN Address space: range of IP Addresses
- Subnets to divide a VCN
#### Gateways
- Internet Gateway: provides a path for network traffic between your VCN and the internet
- NAT Gateway: enables outbound connections to the internet, but blocks inbount connections initiated from the internet
- Dynamic Routing Gateway: virtual router that provides a path for private traffic between your VCM and destinations other than the internet: IPsec VPN & FastConnect
- Service Gateway: lets resources in VCN access public OCI services such as Object Storage but without using an internet or NAT Gateway
#### VCN Security
- Security List: Common Set of Firewall Rules associated with a subnet and applied to all instances launched inside the subnet
- Security list consists of rules that specify the types of traffic allowed in and out of the subnet
- Security list apply to a given instance whether it's talking with another instance in the VCN or a host outside the VCN
- Stateful or stateless
- Network Security Groups consists of set of rules that apply only to a set of VNICs of your choice
#### Peering
- VCN Peering is the process of connecting multiple VCN
- Local VCN Peering: 2 VCN in the same region
- Remote VCN Peering: 2 VNC in different regions
- Peering not transitive
#### Load Balancer
- Tasks: Service Discovery, Health Check, Algorithm
- Benefits: Fault Tolerance, Scale, Naming Abstraction
- Public Load Balancer

### OCI Compute Services

### OCI IAM Services

### OCI Security Services

### OCI Pricing and Billing

### OCI SLA and Support