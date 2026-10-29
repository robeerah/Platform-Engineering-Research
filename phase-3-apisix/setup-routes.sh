#!/bin/bash
ADMIN_API="http://127.0.0.1:9180/apisix/admin"
API_KEY="edd1c9f034335f136f87ad84b625c8f1"

echo "🔧 Configuring APISIX routes..."

# Create route from JSON file
curl -i "$ADMIN_API/routes/1" -X PUT \
  -H "X-API-KEY: $API_KEY" \
  -d @routes/my-webapp.json

echo ""
echo "✅ Route configured!"
echo "🌐 Test at: http://127.0.0.1:9080/api/v1/my-webapp/test"