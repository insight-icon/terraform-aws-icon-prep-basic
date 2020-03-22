
variable "node_type" {
  description = ""
  type        = string
  default     = "prep"
}

variable "consul_enabled" {
  description = ""
  type        = bool
  default     = false
}

variable "prometheus_enabled" {
  description = ""
  type        = bool
  default     = false
}

variable "ssh_user" {
  description = ""
  type        = string
  default     = "ubuntu"
}

variable "name" {
  description = ""
  type        = string
  default     = "prep"
}

variable "monitoring" {
  description = ""
  type        = bool
  default     = true
}

variable "ebs_volume_size" {
  description = ""
  type        = number
  default     = 200
}

variable "root_volume_size" {
  description = ""
  type        = number
  default     = 25
}

variable "instance_type" {
  description = ""
  type        = string
  default     = "m5.large"
}

variable "volume_path" {
  description = ""
  type        = string
  default     = "/dev/xvdf"
}

variable "subnet_id" {
  description = ""
  type        = string
  default     = ""
}

variable "user_data" {
  description = ""
  type        = string
  default     = ""
}

variable "ami_id" {
  description = ""
  type        = string
  default     = ""
}

variable "public_key_path" {
  description = ""
  type        = string
}

variable "private_key_path" {
  description = ""
  type        = string
}

//variable "security_groups" {
//  type = list(string)
//  default = []
//}
// ^^^ EVIL

variable "vpc_security_group_ids" {
  description = ""
  type        = list(string)
  default     = null # For conditional logic to trickle down to module
}

variable "corporate_ip" {
  description = ""
  type        = string
  default     = ""
}

variable "tags" {
  description = ""
  type        = map(string)
  default     = {}
}

variable "playbook_file_path" {
  description = ""
  type        = string
}
variable "roles_dir" {
  description = ""
  type        = string
  default     = "."
}

variable "playbook_vars" {
  description = ""
  type        = map(string)
  default     = {}
}

variable "keystore_password" {
  description = ""
  type        = string
}

variable "keystore_path" {
  description = ""
  type        = string
}

variable "network_name" {
  description = ""
  type        = string
}

variable "main_ip" {
  description = ""
  type        = string
}

variable "eip_id" {
  description = ""
  type        = string
  default     = ""
}

variable "create_eip" {
  description = ""
  type        = bool
  default     = false
}
