// Auto-generated variable declarations from massdriver.yaml
variable "azure_service_principal" {
  type = object({
    data = object({
      client_id       = string
      client_secret   = string
      subscription_id = string
      tenant_id       = string
    })
    specs = object({})
  })
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "monitoring" {
  type = object({
    mode = optional(string)
    alarms = optional(object({
      latency_metric_alert = optional(object({
        aggregation = string
        frequency   = string
        operator    = string
        severity    = number
        threshold   = number
        window_size = string
      }))
      server_errors_metric_alert = optional(object({
        aggregation = string
        frequency   = string
        operator    = string
        severity    = number
        threshold   = number
        window_size = string
      }))
    }))
  })
}
variable "queue" {
  type = object({
    batched_operations  = bool
    duplicate_detection = bool
    session             = bool
  })
}
variable "service" {
  type = object({
    region         = string
    sku            = string
    capacity       = optional(number)
    zone_redundant = optional(bool)
  })
}