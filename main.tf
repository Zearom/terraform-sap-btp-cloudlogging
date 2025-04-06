//main.tf
data "btp_subaccount" "subaccount" {
  id = var.subaccount-id
}

data "btp_subaccount_service_plan" "cloud-logging" {
  subaccount_id = data.btp_subaccount.subaccount.id
  offering_name          = "cloud-logging"
  name = var.cloud-logging-service-plan-name
}

resource "btp_subaccount_service_instance" "cloud-logging" {
  subaccount_id = data.btp_subaccount.subaccount.id
  serviceplan_id = data.btp_subaccount_service_plan.cloud-logging.id
  name           = data.btp_subaccount_service_plan.cloud-logging.offering_name
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

resource "btp_subaccount_service_binding" "additional-service-bindings" {
  for_each = toset(var.additional-service-binding-names)
  name                = each.key
  subaccount_id       = data.btp_subaccount.subaccount.id
  service_instance_id = btp_subaccount_service_instance.cloud-logging.id

  parameters = jsonencode({
    "ingest": {
      "certValidityDays": var.service-binding-ingest-certificate-validity-days
    }
  })

  depends_on = [btp_subaccount_service_instance.cloud-logging]
}
