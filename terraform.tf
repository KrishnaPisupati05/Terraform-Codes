terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "7dc67ccd-ca99-4c09-b0a3-1cba17599b73"
}

