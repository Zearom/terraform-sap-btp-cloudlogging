variable "subaccount-id" {
  description = "The ID of the subaccount"
  type        = string
}

variable "cloud-logging-service-plan-name" {
  description = "The name of the cloud logging service plan"
  default     = "dev"

  validation {
    condition     = contains(["dev", "standard", "large", "build-code"], var.cloud-logging-service-plan-name)
    error_message = "The cloud logging service plan name must be one of: dev, standard, large or build-code."
  }

  type        = string
}

variable "default-service-binding-name" {
  description = "The name of the default service binding"
  default     = "default"
  type        = string
}