job "my-webapp" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count = 1

    network {
      port "http" {
        to = 5678
      }
    }

    service {
      name = "my-webapp"
      port = "http"

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "echo" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        args  = ["-text", "Hello from Platform Engineering!", "-listen", ":5678"]
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}