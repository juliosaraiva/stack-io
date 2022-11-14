terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.15.0"
    }
  }
  required_version = ">= 1.3"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_manifest" "mysql-deployment" {
  manifest = yamldecode(file("../kubernetes/mysql-deployment.yml"))
  depends_on = [
    kubernetes_manifest.app-namespace
  ]
}

resource "kubernetes_manifest" "mysql-service" {
  manifest = yamldecode(file("../kubernetes/mysql-service.yml"))
  depends_on = [
    kubernetes_manifest.app-namespace
  ]
}

resource "kubernetes_manifest" "app-namespace" {
  manifest = yamldecode(file("../kubernetes/namespace.yml"))

  depends_on = [
    kubernetes_manifest.app-namespace
  ]
}

resource "kubernetes_manifest" "app-secret" {
  manifest = yamldecode(file("../kubernetes/secrets.yml"))

  depends_on = [
    kubernetes_manifest.app-namespace
  ]
}

resource "kubernetes_manifest" "app-deployment" {
  manifest = yamldecode(file("../kubernetes/deployment.yml"))

  depends_on = [
    kubernetes_manifest.app-namespace
  ]
}

resource "kubernetes_manifest" "app-service" {
  manifest = yamldecode(file("../kubernetes/service.yml"))

  depends_on = [
    kubernetes_manifest.app-namespace
  ]
}

