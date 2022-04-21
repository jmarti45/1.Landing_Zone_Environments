terraform {
  backend "azurerm" {
    resource_group_name  = "kafkajmd"
    storage_account_name = "salandingzonetf"
    container_name       = "tfstates"
    #sas_token            = "$SAS_TOKEN"
    sas_token = "?sv=2020-08-04&ss=b&srt=sco&sp=rwdlactf&se=2023-04-14T14:21:41Z&st=2022-04-08T06:21:41Z&spr=https&sig=MeJakfhltFFgYBPsniDZ%2BtkdXksPsngOj3K3pZGHy%2FY%3D"
    key       = "terraformgithubexample04.tfstate"
  }


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true


    }
  }
}
/*
# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
*/

