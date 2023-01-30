terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.1.0-alpha"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.25.3"
}

locals {
  cluster_name = "minikube-${var.env_name}"
}

resource "minikube_cluster" "docker" {
  driver       = "docker"
  cluster_name = local.cluster_name
  #addons = [
  #  "default-storageclass",
  #]
}
