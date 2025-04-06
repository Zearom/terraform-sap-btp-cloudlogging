//main.tf
data "btp_subaccount" "subaccount" {
  id = var.subaccount-id
}

data "btp_subaccount_service_plan" "cloud-logging-dev" {
  subaccount_id = data.btp_subaccount.subaccount.id
  offering_name          = "cloud-logging"
  name = "dev"
}

data "btp_subaccount_service_plan" "cloud-logging-standard" {
  subaccount_id = data.btp_subaccount.subaccount.id
  offering_name          = "cloud-logging"
  name = "standard"
}

data "btp_subaccount_service_plan" "cloud-logging-large" {
  subaccount_id = data.btp_subaccount.subaccount.id
  offering_name          = "cloud-logging"
  name = "large"
}

data "btp_subaccount_service_plan" "cloud-logging-build-code" {
  subaccount_id = data.btp_subaccount.subaccount.id
  offering_name          = "cloud-logging"
  name = "build-code"
}

resource "btp_subaccount_service_instance" "cloud-logging" {
  subaccount_id = data.btp_subaccount.subaccount.id
  serviceplan_id = data.btp_subaccount_service_plan.cloud-logging-dev.id
  name           = data.btp_subaccount_service_plan.cloud-logging-dev.offering_name
  parameters = jsonencode({})
}

resource "btp_subaccount_service_binding" "cloud-logging-default" {
  subaccount_id       = data.btp_subaccount.subaccount.id
  service_instance_id = btp_subaccount_service_instance.cloud-logging.id
  name                = var.default-service-binding-name
  parameters = jsonencode({
    "ingest": {
      "certValidityDays": 90
    }
  })

  depends_on = [btp_subaccount_service_instance.cloud-logging]
}
