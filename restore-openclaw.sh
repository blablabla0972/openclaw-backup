#!/bin/bash
# OpenClaw Restore Script
# Restores OpenClaw from backup

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCLAW_DIR="${HOME}/.openclaw"
ARCHIVE=${1:-""}

echo "🔧 OpenClaw Restore Script"
echo "========================="
echo "Restore Time: $(date)"
echo ""

# Check for archive
if [ -z "$ARCHIVE" ]; then
    # Find latest backup
    LATEST=$(ls -t "$SCRIPT_DIR"/openclaw-backup-*.tar.gz 2>/dev/null | head -1)
    if [ -z "$LATEST" ]; then
        echo "❌ No backup archive found!"
        echo "Usage: ./restore-openclaw.sh [archive.tar.gz]"
        exit 1
    fi
    ARCHIVE="$LATEST"
    echo "Using latest backup: $ARCHIVE"
else
    echo "Using specified backup: $ARCHIVE"
fi

if [ ! -f "$ARCHIVE" ]; then
    echo "❌ Archive not found: $ARCHIVE"
    exit 1
fi

# Extract backup
TEMP_DIR=$(mktemp -d)
echo "📦 Extracting backup..."
tar -xzf "$ARCHIVE" -C "$TEMP_DIR"

# 1. Restore Configuration
echo "📁 Restoring configuration..."
if [ -f "$TEMP_DIR/config/openclaw.json" ]; then
    mkdir -p "$OPENCLAW_DIR"
    cp "$TEMP_DIR/config/openclaw.json" "$OPENCLAW_DIR/"
    echo "  ✓ openclaw.json"
fi

# 2. Restore Credentials
echo "🔐 Restoring credentials..."
if [ -d "$TEMP_DIR/credentials" ]; then
    mkdir -p "$OPENCLAW_DIR/credentials"
    cp -r "$TEMP_DIR/credentials/"* "$OPENCLAW_DIR/credentials/" 2>/dev/null || true
    echo "  ✓ credentials/"
fi

# 3. Restore Skills
echo "🎯 Restoring skills..."
if [ -d "$TEMP_DIR/skills" ]; then
    mkdir -p "$OPENCLAW_DIR/skills"
    cp -r "$TEMP_DIR/skills/"* "$OPENCLAW_DIR/skills/" 2>/dev/null || true
    echo "  ✓ skills/"
fi

# 4. Restore Workspace
echo "💼 Restoring workspace..."
if [ -d "$TEMP_DIR/workspace" ]; then
    mkdir -p "$OPENCLAW_DIR/workspace"
    cp -r "$TEMP_DIR/workspace/"* "$OPENCLAW_DIR/workspace/" 2>/dev/null || true
    echo "  ✓ workspace/"
fi

# 5. Restore Memory
echo "🧠 Restoring memory..."
if [ -d "$TEMP_DIR/memory" ]; then
    mkdir -p "$OPENCLAW_DIR/workspace/memory"
    cp -r "$TEMP_DIR/memory/"* "$OPENCLAW_DIR/workspace/memory/" 2>/dev/null || true
    echo "  ✓ memory/"
fi

# 6. Restore Cron Jobs
echo "⏰ Restoring cron jobs..."
if [ -f "$TEMP_DIR/cron/openclaw.cron" ]; then
    crontab "$TEMP_DIR/cron/openclaw.cron" 2>/dev/null || echo "  ⚠️  Cron restore skipped"
    echo "  ✓ cron jobs"
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "✅ Restore Complete!"
echo ""
echo "Next steps:"
echo "1. Check config: cat $OPENCLAW_DIR/openclaw.json"
echo "2. Install dependencies: cd $OPENCLAW_DIR/workspace && npm install"
echo "3. Start OpenClaw: openclaw gateway start"
echo ""

# Validate installation
echo "🔍 Validating installation..."
if command -v openclaw &> /dev/null; then
    echo "  ✓ OpenClaw CLI found"
    openclaw --version
else
    echo "  ⚠️  OpenClaw CLI not found. Install with: npm install -g openclaw"
fi

echo ""
echo "🎉 All done!"
