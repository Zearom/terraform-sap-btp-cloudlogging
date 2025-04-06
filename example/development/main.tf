module "cloudlogging" {
  source = "../../"

  cloud-logging-service-plan-name = "dev"
  subaccount-id = data.btp_subaccount.subaccount.id
  default-service-binding-name = "default-binding"
  additional-service-binding-names = ["additional-binding-1", "additional-binding-2"]
}

data "btp_subaccount" "subaccount" {
  region    = var.subaccount-region
  subdomain = var.subaccount-name
}

output "subaccountid" {
  value = data.btp_subaccount.subaccount.id
}