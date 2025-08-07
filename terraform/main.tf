terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.4.0"
    }
  }
}

provider "fabric" {
  use_cli = true
}

data "fabric_capacity" "testfabricgigax" {
  display_name = "testfabricgigax"
}

resource "fabric_workspace" "demo" {
  display_name = "demo-workspace"
  capacity_id  = data.fabric_capacity.testfabricgigax.id
}

resource "fabric_eventstream" "demo_stream" {
  display_name = "demo-eventstream"
  workspace_id = fabric_workspace.demo.id
  description  = "Eventstream de démonstration pour vélos"
  format       = "Default"
  definition_update_enabled = false
  definition = {
    "eventstream.json" = {
      source = "definition/Eventstream.json"
    }
  }
}

resource "fabric_eventhouse" "demo_house" {
  display_name              = "demo_eventhouse"
  description               = "Example with definition bootstrapping"
  workspace_id              = fabric_workspace.demo.id
  format                    = "Default"
  definition_update_enabled = false # <-- Disable definition update
  definition = {
    "EventhouseProperties.json" = {
      source = "definition/EventhouseProperties.json"
    }
  }
}
