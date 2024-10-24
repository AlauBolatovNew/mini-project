output "names" {
  value = {
    frontend_autoscaling_group_name = module.frontend_autoscaling_group.name
    backend_autoscaling_group_name  = module.backend_autoscaling_group.name
  }
}