terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.0.0,"
        }
    }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "./modules/network"
}

module "web" {
  source              = "./modules/web"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "app" {
  source              = "./modules/app"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "db" {
  source              = "./modules/db"
  resource_group_name = var.resource_group_name
  location            = var.location
}
