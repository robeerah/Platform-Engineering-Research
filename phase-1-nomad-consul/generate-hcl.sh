#!/bin/bash
# This script simulates an internal platform CLI
# It takes a simple JSON config and generates complex Nomad HCL

CONFIG_FILE=$1

if [ -z "$CONFIG_FILE" ]; then
  echo "Usage: $0 <config.json>"
  exit 1
fi

# Parse JSON (requires jq: brew install jq)
APP_NAME=$(jq -r '.app_name' "$CONFIG_FILE")
MESSAGE=$(jq -r '.message' "$CONFIG_FILE")
CPU=$(jq -r '.cpu' "$CONFIG_FILE")
MEMORY=$(jq -r '.memory' "$CONFIG_FILE")
COUNT=$(jq -r '.count' "$CONFIG_FILE")

# Generate HCL
cat > "${APP_NAME}.nomad.hcl" <<EOF
job "${APP_NAME}" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count = ${COUNT}

    network {
      port "http" { to = 5678 }
    }

    service {
      name = "${APP_NAME}"
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
        args  = ["-text", "${MESSAGE}", "-listen", ":5678"]
      }
      resources {
        cpu    = ${CPU}
        memory = ${MEMORY}
      }
    }
  }
}
EOF

echo "✅ Generated ${APP_NAME}.nomad.hcl"
echo "🚀 Deploy with: nomad job run ${APP_NAME}.nomad.hcl"