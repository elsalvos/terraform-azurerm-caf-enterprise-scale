# Use variables to customize the deployment

variable "root_id" {
  type    = string
  default = "top-es" #"es"
}

variable "root_name" {
  type    = string
  default = "top-corp" #"Enterprise-Scale"
}


variable "deploy_management_resources" {
  type    = bool
  default = true
}

variable "log_retention_in_days" {
  type    = number
  default = 50
}

variable "security_alerts_email_address" {
  type    = string
  default = "cabrego@microsoft.com" # Replace this value with your own email address.
}

variable "management_resources_location" {
  type    = string
  default = "westus3"
}

variable "management_resources_tags" {
  type = map(string)
  default = {
    demo_type = "elz-cx1"
    support   = "cabrego"
  }
}