resource "yandex_lb_target_group" "grafana-balancer-group" {
  name = format("lb-workers-group-%s", terraform.workspace)
  depends_on         = [yandex_compute_instance_group.worker-nodes-group]

  dynamic "target" {
    for_each = yandex_compute_instance_group.worker-nodes-group.instances
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "grafana-balancer" {
  name = "grafana-balancer"

  listener {
    name = "grafana-listener"
    port = 80
    target_port = 3000
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.grafana-balancer-group.id

    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 3000
      }
    }
  }
}
