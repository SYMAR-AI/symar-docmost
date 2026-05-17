#!/usr/bin/env bash
# Seed script for local dev environment
# Creates workspace, admin user, and sample pages
# Re-runnable: skips setup if workspace already exists, skips existing pages
set -euo pipefail

API="http://localhost:3000/api"
EMAIL="nikola@symar.ai"
PASSWORD="dev12345"
WORKSPACE_NAME="SYMAR Knowledge Hub"
COOKIE_JAR="/tmp/docmost-seed-cookies.txt"

cleanup() { rm -f "$COOKIE_JAR"; }
trap cleanup EXIT

echo "==> Checking if server is running..."
if ! curl -sf "$API/health" > /dev/null 2>&1; then
  echo "ERROR: Server not running at $API. Start it with: pnpm run dev"
  exit 1
fi

# Try setup first (fresh DB), fall back to login (already seeded)
echo "==> Setting up workspace and admin user..."
SETUP_HTTP=$(curl -s -o /dev/null -w "%{http_code}" -c "$COOKIE_JAR" \
  -X POST "$API/auth/setup" \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"Nikola\",
    \"email\": \"$EMAIL\",
    \"password\": \"$PASSWORD\",
    \"workspaceName\": \"$WORKSPACE_NAME\"
  }")

if [ "$SETUP_HTTP" = "200" ] || [ "$SETUP_HTTP" = "201" ]; then
  echo "    Workspace created fresh."
else
  echo "    Workspace already exists (HTTP $SETUP_HTTP). Logging in..."
  LOGIN_HTTP=$(curl -s -o /dev/null -w "%{http_code}" -c "$COOKIE_JAR" \
    -X POST "$API/auth/login" \
    -H "Content-Type: application/json" \
    -d "{\"email\": \"$EMAIL\", \"password\": \"$PASSWORD\"}")
  if [ "$LOGIN_HTTP" != "200" ] && [ "$LOGIN_HTTP" != "201" ]; then
    echo "ERROR: Login failed (HTTP $LOGIN_HTTP). Wrong password?"
    exit 1
  fi
fi

echo "==> Authenticated."

# Get the default space
echo "==> Fetching spaces..."
SPACES_RESPONSE=$(curl -sf -b "$COOKIE_JAR" -X POST "$API/spaces" \
  -H "Content-Type: application/json" \
  -d '{"limit": 10}')

SPACE_ID=$(echo "$SPACES_RESPONSE" | python3 -c "
import sys, json
data = json.load(sys.stdin).get('data', {})
items = data.get('items', [])
print(items[0]['id'] if items else '')
" 2>/dev/null || echo "")

if [ -z "$SPACE_ID" ]; then
  echo "ERROR: Could not find default space"
  exit 1
fi

echo "    Space ID: $SPACE_ID"

# Check existing pages
EXISTING=$(curl -sf -b "$COOKIE_JAR" -X POST "$API/pages/sidebar-pages" \
  -H "Content-Type: application/json" \
  -d "{\"spaceId\": \"$SPACE_ID\"}" | python3 -c "
import sys, json
items = json.load(sys.stdin).get('data', {}).get('items', [])
print(len(items))
" 2>/dev/null || echo "0")

if [ "$EXISTING" -ge 2 ]; then
  echo "==> Pages already exist ($EXISTING found). Skipping creation."
else
  echo "==> Creating sample pages..."
  
  create_page() {
    local title="$1"
    local result
    result=$(curl -s -b "$COOKIE_JAR" -X POST "$API/pages/create" \
      -H "Content-Type: application/json" \
      -d "{\"spaceId\": \"$SPACE_ID\", \"title\": \"$title\"}")
    local slug
    slug=$(echo "$result" | python3 -c "import sys,json; print(json.load(sys.stdin).get('data',{}).get('slugId','?'))" 2>/dev/null || echo "?")
    echo "    Created: $title (slug: $slug)"
  }

  create_page "Getting Started with SYMAR Knowledge Hub"
  create_page "Project Planning Template"
fi

echo ""
echo "==> Seed complete!"
echo "    Login: $EMAIL / $PASSWORD"
echo "    URL:   http://localhost:5173"
