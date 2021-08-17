# provider variables
variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}

# SCDN Domain variables
variable "create_domain" {
  description = "Whether to create a new SCDN domain. If true, the domain_name is required."
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "The name SCDN domain. If it not existed, please set create_domain to true to create a new one."
  type        = string
  default     = ""
}

variable "check_url" {
  description = "The URL that is used to test the accessibility of the origin."
  type        = string
  default     = ""
}
variable "biz_name" {
  description = "from the Business Type Drop-down List. Valid values: download, image, scdn, video."
  type        = string
  default     = null
}
variable "cert_infos" {
  description = "Certificate Information."
  type        = map(string)
  default     = {}
}
variable "resource_group_id" {
  description = "The ID of the resource group."
  type        = string
  default     = ""
}
variable "sources" {
  description = "The origin information."
  type        = map(string)
  default     = null
}
variable "status" {
  description = "The domain status. Valid values: online, offline."
  type        = string
  default     = "online"
}
# SCDN Domain config variables
variable "domain_configs" {
  description = "The domain configs."
  type = list(object({
    function_name = string
    function_args = list(object({
      arg_name  = string
      arg_value = string
    }))
  }))
  default = []
}
