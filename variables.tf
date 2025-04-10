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

  type = string
}

variable "default-service-binding-name" {
  description = "The name of the default service binding"
  default     = "default"
  type        = string
}

variable "additional-service-binding-names" {
  description = "Additional service binding names"
  type        = list(string)
  nullable    = true
}

variable "service-binding-ingest-certificate-validity-days" {
  description = "The number of days the certificate is valid for. Default is 90 days, minimum value is one day, maximum value are 90 days."

  validation {
    condition     = var.service-binding-ingest-certificate-validity-days >= 1 && var.service-binding-ingest-certificate-validity-days <= 90
    error_message = "The certificate validity days must be between 1 and 90."
  }

  type     = number
  default  = 90
  nullable = false
}