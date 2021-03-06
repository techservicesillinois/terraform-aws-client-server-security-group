variable "cidr_blocks_extra" {
  description = "Optional list of CIDR blocks"
  type        = list(string)
  default     = []
}

variable "name_prefix" {
  description = "Prefix to prepend to autogenerated security group names"
  default     = ""
}

variable "client_sg_name" {
  description = "Client security group name"
  default     = ""
}

variable "server_sg_name" {
  description = "Server security group name"
  default     = ""
}

variable "port" {
  description = "Server port"
  type        = number
}

variable "protocol" {
  description = "Server protocol (e.g., icmp, tcp, udp)"
  default     = "tcp"
}

variable "tags" {
  description = "Tags to be applied"
  type        = map(string)
  default     = {}
}

variable "vpc" {
  description = "Name of VPC"
}
