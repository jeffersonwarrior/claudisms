#!/usr/bin/env bash
# repair-install.sh - Fix all claudisms installation issues
set -euo pipefail

PLUGIN_NAME="claudisms"
MARKETPLACE_DIR="${HOME}/.claude/plugins/marketplaces/${PLUGIN_NAME}"
INSTALLED_PLUGINS="${HOME}/.claude/plugins/installed_plugins.json"
KNOWN_MARKETPLACES="${HOME}/.claude/plugins/known_marketplaces.json"

echo "🔧 Claudisms Installation Repair"
echo "================================="

# 1. Remove old claudisms directory (legacy location)
if [[ -d ~/.claude/plugins/claudisms ]]; then
  echo "✓ Removing legacy plugin directory..."
  rm -rf ~/.claude/plugins/claudisms
fi

# 2. Ensure marketplace directory exists
mkdir -p "$MARKETPLACE_DIR"

# 3. Copy/update files from dev repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -d "$SCRIPT_DIR" ]]; then
  echo "✓ Syncing files from $SCRIPT_DIR..."
  rsync -av --exclude='.git' --exclude='tmp/' "$SCRIPT_DIR/" "$MARKETPLACE_DIR/"
fi

# 4. Fix marketplace.json naming conflict
echo "✓ Fixing marketplace.json..."
cat > "$MARKETPLACE_DIR/.claude-plugin/marketplace.json" << 'EOF'
{
  "name": "claudisms",
  "owner": {
    "name": "Jefferson Warrior"
  },
  "plugins": [
    {
      "name": "claudisms",
      "source": "./",
      "description": "Operational guidelines: terse responses, sequential execution, no destructive ops without confirmation"
    }
  ]
}
EOF

# 5. Update installed_plugins.json
echo "✓ Updating installed_plugins.json..."
cat > "$INSTALLED_PLUGINS" << EOF
{
  "version": 1,
  "plugins": {
    "claudisms@claudisms": {
      "version": "2.2.0",
      "installedAt": "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)",
      "lastUpdated": "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)",
      "installPath": "$MARKETPLACE_DIR/",
      "gitCommitSha": "$(cd "$SCRIPT_DIR" && git rev-parse HEAD 2>/dev/null || echo 'local')",
      "isLocal": true
    }
  }
}
EOF

# 6. Update known_marketplaces.json
echo "✓ Updating known_marketplaces.json..."
cat > "$KNOWN_MARKETPLACES" << EOF
{
  "claudisms": {
    "source": {
      "url": "https://github.com/jeffersonwarrior/claudisms.git",
      "ref": "main"
    },
    "installLocation": "$MARKETPLACE_DIR",
    "lastUpdated": "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)"
  }
}
EOF

# 7. Initialize settings if not exists
if [[ ! -f "$MARKETPLACE_DIR/settings.json" ]]; then
  echo "✓ Creating default settings.json..."
  cp "$MARKETPLACE_DIR/settings.example.json" "$MARKETPLACE_DIR/settings.json"
fi

# 8. Set permissions
chmod +x "$MARKETPLACE_DIR"/bin/* 2>/dev/null || true
chmod +x "$MARKETPLACE_DIR"/hooks-handlers/* 2>/dev/null || true
chmod +x "$MARKETPLACE_DIR"/commands/*.sh 2>/dev/null || true
chmod +x "$MARKETPLACE_DIR"/lib/*.sh 2>/dev/null || true

# 9. Verify installation
echo ""
echo "✅ Installation repaired!"
echo ""
echo "Location: $MARKETPLACE_DIR"
echo "Plugin ID: claudisms@claudisms"
echo ""
echo "Files installed:"
ls -lh "$MARKETPLACE_DIR" | tail -n +2 | wc -l | xargs echo "  Files:"
echo ""
echo "⚠️  Restart Claude Code to load changes"
echo ""
echo "Test with: /claudisms-settings"
