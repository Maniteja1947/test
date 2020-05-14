provider "azurerm" {
    version = "~> 1.33.1"

# skip_provider_registration = true
}

provider "dns" {
    version = "2.1.0"
}

provider "null" {
    version = "2.1.0"
}

provider "random" {
    version = "2.1.0"
}

provider "template" {
    version = "2.1.0"
}
