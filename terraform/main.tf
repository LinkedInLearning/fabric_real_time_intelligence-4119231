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
  preview = true
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
  definition = {
    "eventstream.json" = {
      source = "definition/Eventstream.json"
    }
  }
}

resource "fabric_eventhouse" "demo_house" {
  display_name = "demo-eventhouse"
  description  = "Example with definition bootstrapping"
  workspace_id = fabric_workspace.demo.id
  format       = "Default"
  definition = {
    "EventhouseProperties.json" = {
      source = "definition/EventhouseProperties.json"
    }
  }
}

resource "fabric_activator" "demo_activator" {
  display_name = "demo-activator"
  description  = "Example of Activator"
  workspace_id = fabric_workspace.demo.id
  format       = "Default"
  definition = {
    "ReflexEntities.json" = {
      source = "definition/ReflexEntities.json"
    }
  }
}
