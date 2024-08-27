variable "region" {
  description = "OCI region"
  type        = string
  default     = "us-ashburn-1"
}

variable "compartment_id" {
  description = "The compartment OCID where the resources will be created"
  type        = string
  default = "ocid1.compartment.oc1..aaaaaaaavith6mn3xjrcrjtnrj2oimzhsib4u6ocygk2ldjgc73tyn3vyh3q"
}

variable "availability_domain" {
  description = "Availability Domain"
  type        = string
  default     = "hgiL:US-ASHBURN-AD-1"
}

# variable for os image_id
variable "os_image_id" {
  description = "The OCID of the OS image to use for the VM"
  type        = string
  default     = "ocid1.image.oc1.iad.aaaaaaaay66pu7z27ltbx2uuatzgfywzixbp34wx7xoze52pk33psz47vlfa"
}

# variable for shape
variable "node_shape" {
  description = "The shape of the VM"
  type        = string
  default     = "VM.Standard2.1"
}
