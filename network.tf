# Create VCN
resource "oci_core_vcn" "dev_vcn" {
  cidr_block   = "10.0.0.0/16"
  display_name = "dev-vcn"
  compartment_id = var.compartment_id
}

# Create Internet Gateway
resource "oci_core_internet_gateway" "dev_igw" {
  display_name   = "dev-igw"
  vcn_id         = oci_core_vcn.dev_vcn.id
  compartment_id = var.compartment_id
}

# Create Route Table
resource "oci_core_route_table" "dev_rt" {
  vcn_id         = oci_core_vcn.dev_vcn.id
  compartment_id = var.compartment_id
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.dev_igw.id
  }
}

# Create Subnet for OKE Node Pool
resource "oci_core_subnet" "node_pool_subnet" {
  cidr_block     = "10.0.1.0/24"
  vcn_id         = oci_core_vcn.dev_vcn.id
  compartment_id = var.compartment_id
  display_name   = "oke-node-pool-subnet"
  route_table_id = oci_core_route_table.dev_rt.id
  security_list_ids = [oci_core_vcn.dev_vcn.default_security_list_id]
  prohibit_public_ip_on_vnic = false
}

# Create Subnet for Service Load Balancer
resource "oci_core_subnet" "service_lb_subnet" {
  cidr_block     = "10.0.2.0/24"
  vcn_id         = oci_core_vcn.dev_vcn.id
  compartment_id = var.compartment_id
  display_name   = "service-lb-subnet"
  route_table_id = oci_core_route_table.dev_rt.id
  security_list_ids = [oci_core_vcn.dev_vcn.default_security_list_id]
  prohibit_public_ip_on_vnic = false
}