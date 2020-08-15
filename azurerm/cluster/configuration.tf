locals {
  # apps config and merged ops config
  workspaces = {
    apps = var.configuration["apps"]
    ops  = merge(var.configuration["apps"], var.configuration["ops"])
  }

  # current workspace config
  cfg = local.workspaces[terraform.workspace]

  name_prefix = local.cfg["name_prefix"]

  base_domain = local.cfg["base_domain"]

  resource_group = local.cfg["resource_group"]

  dns_prefix = lookup(local.cfg, "dns_prefix", "api")

  default_node_pool_name = lookup(local.cfg, "default_node_pool_name", "default")
  default_node_pool_type = lookup(local.cfg, "default_node_pool_type", "VirtualMachineScaleSets")

  default_node_pool_enable_auto_scaling = lookup(local.cfg, "default_node_pool_enable_auto_scaling", true)
  default_node_pool_min_count           = lookup(local.cfg, "default_node_pool_min_count", "1")
  default_node_pool_max_count           = lookup(local.cfg, "default_node_pool_max_count", "1")
  default_node_pool_node_count          = lookup(local.cfg, "default_node_pool_node_count", "1")

  default_node_pool_vm_size = lookup(local.cfg, "default_node_pool_vm_size", "Standard_B2s")

  default_node_pool_os_disk_size_gb = lookup(local.cfg, "default_node_pool_os_disk_size_gb", "30")

  manifest_path_default = "manifests/overlays/${terraform.workspace}"
  manifest_path         = var.manifest_path != null ? var.manifest_path : local.manifest_path_default
}
