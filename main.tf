provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/scdn"
}

// Domain
resource "alicloud_scdn_domain" "this" {
  count             = var.create_domain ? 1 : 0
  domain_name       = var.domain_name
  check_url         = var.check_url
  resource_group_id = var.resource_group_id
  biz_name          = var.biz_name
  sources {
    content  = lookup(var.sources, "content", null)
    enabled  = lookup(var.sources, "enabled", "online")
    type     = lookup(var.sources, "type", null)
    port     = lookup(var.sources, "port", 80)
    priority = lookup(var.sources, "priority", 20)
  }
  cert_infos {
    cert_name    = lookup(var.cert_infos, "cert_name", null)
    cert_type    = lookup(var.cert_infos, "cert_type", null)
    ssl_pri      = lookup(var.cert_infos, "ssl_pri", null)
    ssl_protocol = lookup(var.cert_infos, "ssl_protocol", "on")
    ssl_pub      = lookup(var.cert_infos, "ssl_pub", null)
  }
  status = var.status
}

// Domain configs
resource "alicloud_scdn_domain_config" "this" {
  count         = length(var.domain_configs)
  domain_name   = local.domain_name
  function_name = var.domain_configs[count.index].function_name
  dynamic "function_args" {
    for_each = var.domain_configs[count.index].function_args
    content {
      arg_name  = function_args.value["arg_name"]
      arg_value = function_args.value["arg_value"]
    }
  }
}
