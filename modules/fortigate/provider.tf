terraform {
  required_version = ">= 1.4.0"

  required_providers {
        fortios = {
      source  = "fortinetdev/fortios"
      version = ">= 1.23.0"
    }
  }
}