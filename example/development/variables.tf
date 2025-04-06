variable "globalaccount" {
  description = "The global account"
  sensitive   = true
  type        = string
}

variable "subaccount-region" {
  description = "The region of the subaccount"
  sensitive   = true
  type        = string
}

variable "subaccount-name" {
  description = "The subaccount name"
  sensitive   = true
  type        = string
}

