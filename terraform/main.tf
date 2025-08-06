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
  display_name = var.workspace_name
  capacity_id  = data.fabric_capacity.testfabricgigax.id
}

resource "fabric_eventstream" "demo_stream" {
  display_name = var.eventstream_name
  workspace_id = fabric_workspace.demo.id
  description  = "Eventstream de démonstration pour vélos"
}
