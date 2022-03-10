data "alicloud_resource_manager_resource_groups" "default" {
}

module "scdn" {
  source = "../.."

  #alicloud_scdn_domain
  create_domain     = true
  domain_name       = "tf-testacccn-hangzhou.xiaozhu.com"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  biz_name          = var.biz_name
  sources           = var.sources
  cert_infos        = var.cert_infos
  status            = var.status

  #alicloud_scdn_domain_config
  domain_configs = [
    {
      function_name = "ip_allow_list_set"
      function_args = var.function_args
    }
  ]

}