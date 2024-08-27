# Create OKE Cluster
resource "oci_containerengine_cluster" "dev_oke_cluster" {
  compartment_id    = var.compartment_id
  name              = "dev-oke-cluster"
  vcn_id            = oci_core_vcn.dev_vcn.id
  kubernetes_version = "v1.30.1"
  
  options {
    service_lb_subnet_ids = [oci_core_subnet.service_lb_subnet.id]
  }
  
  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = oci_core_subnet.service_lb_subnet.id
  }
}

# Create Node Pool for OKE Cluster
resource "oci_containerengine_node_pool" "dev_node_pool" {
  cluster_id     = oci_containerengine_cluster.dev_oke_cluster.id
  compartment_id = var.compartment_id
  name           = "dev-node-pool"
  kubernetes_version = oci_containerengine_cluster.dev_oke_cluster.kubernetes_version
  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
      subnet_id           = oci_core_subnet.node_pool_subnet.id
    }

    size = 2
  }

  node_shape = var.node_shape

  node_source_details {
    source_type = "image"
    image_id = var.os_image_id
  }
}
  
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}
