variable "tenant_id" {
    description = "tenant id of the azure account"
    type = string
  
}

variable "object_id" {
    description = "object id of the azure account"
  type = string
}

variable "my_secret" {
    description = "secret"
    type = string
  
}

variable "administrator_login" {
    description = "login id"
    type = string  
}

variable "administrator_login_password" {
    description = "password"
    type = string  
}

variable "repository_token" {
    description = "token"
    type = string
  
}