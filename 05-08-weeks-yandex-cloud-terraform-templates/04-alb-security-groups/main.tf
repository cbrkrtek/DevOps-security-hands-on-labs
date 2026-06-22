resource "yandex_alb_target_group" "web_target_group" {
  name = "web-target-group"
}

resource "yandex_alb_backend_group" "web_backend_group" {
  name = "web-backend-group"

  http_backend {
    name             = "http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.web_target_group.id]
    
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout          = "1s"
      interval         = "2s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "tf_router" {
  name = "tf-http-router"
}

resource "yandex_alb_virtual_host" "router_host" {
  name           = "router-host"
  http_router_id = yandex_alb_http_router.tf_router.id
  route {
    name = "route-http"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web_backend_group.id
        timeout          = "60s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "alb" {
  name               = "app-load-balancer"
  network_id         = yandex_vpc_network.core_network.id
  security_group_ids = [yandex_vpc_security_group.alb_sg.id]

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet_a.id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet_b.id
    }
  }

  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [80]
    }
    http {
      handler { 
        http_router_id = yandex_alb_http_router.tf_router.id 
      }
    }
  }
} 