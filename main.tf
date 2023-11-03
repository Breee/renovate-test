terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {}

resource "docker_container" "nginx" {
  image = "nginx:1.25.3"
  name  = "tutorial"
  labels {
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label = "traefik.http.routers.tutorial-nginx.rule"
    value = "Host(`tutorial-nginx.example.com`)"
  }
  labels {
    label = "traefik.http.services.tutorial-nginx.loadbalancer.server.port"
    value = "80"
  }
  networks_advanced {
    name = "proxy"
  }
}
