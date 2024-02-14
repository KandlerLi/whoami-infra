variable "domain" {
  type    = string
  default = "jkandler.de"
}

variable "az_count" {
  type    = number
  default = 3
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.1.0.0/16"
}
