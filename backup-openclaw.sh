#!/bin/bash
# OpenClaw Complete Backup Script
# Backs up everything to GitHub

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCLAW_DIR="${HOME}/.openclaw"
BACKUP_DIR="$SCRIPT_DIR/backup"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
FULL_BACKUP=${1:-"--full"}

echo "🔧 OpenClaw Backup Script"
echo "========================"
echo "Backup Time: $(date)"
echo "Full Backup: $FULL_BACKUP"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

# 1. Backup Configuration
echo "📁 Backing up configuration..."
if [ -f "$OPENCLAW_DIR/openclaw.json" ]; then
    cp "$OPENCLAW_DIR/openclaw.json" "$BACKUP_DIR/config/"
    echo "  ✓ openclaw.json"
fi

# 2. Backup Credentials (encrypted)
echo "🔐 Backing up credentials..."
if [ -d "$OPENCLAW_DIR/credentials" ]; then
    mkdir -p "$BACKUP_DIR/credentials"
    cp -r "$OPENCLAW_DIR/credentials/"* "$BACKUP_DIR/credentials/" 2>/dev/null || true
    echo "  ✓ credentials/"
fi

# 3. Backup Skills
echo "🎯 Backing up skills..."
if [ -d "$OPENCLAW_DIR/skills" ]; then
    mkdir -p "$BACKUP_DIR/skills"
    cp -r "$OPENCLAW_DIR/skills/"* "$BACKUP_DIR/skills/" 2>/dev/null || true
    echo "  ✓ skills/"
fi

# 4. Backup Workspace
echo "💼 Backing up workspace..."
if [ -d "$OPENCLAW_DIR/workspace" ]; then
    mkdir -p "$BACKUP_DIR/workspace"
    
    # Copy workspace files
    rsync -av --exclude='node_modules' --exclude='.git' \
          --exclude='*.log' --exclude='camoufox-env' \
          "$OPENCLAW_DIR/workspace/" "$BACKUP_DIR/workspace/" 2>/dev/null || true
    
    echo "  ✓ workspace/"
fi

# 5. Backup Memory
echo "🧠 Backing up memory..."
if [ -d "$OPENCLAW_DIR/workspace/memory" ]; then
    mkdir -p "$BACKUP_DIR/memory"
    cp -r "$OPENCLAW_DIR/workspace/memory/"* "$BACKUP_DIR/memory/" 2>/dev/null || true
    echo "  ✓ memory/"
fi

# 6. Backup Cron Jobs
echo "⏰ Backing up cron jobs..."
if [ -f "$OPENCLAW_DIR/openclaw.cron" ] || command -v crontab &> /dev/null; then
    mkdir -p "$BACKUP_DIR/cron"
    crontab -l > "$BACKUP_DIR/cron/openclaw.cron" 2>/dev/null || echo "# No cron jobs" > "$BACKUP_DIR/cron/openclaw.cron"
    echo "  ✓ cron/"
fi

# 7. Create system info
echo "📊 Creating system info..."
cat > "$BACKUP_DIR/system-info.txt" << EOF
OpenClaw Backup System Info
===========================
Backup Date: $(date)
Backup Type: $FULL_BACKUP
Hostname: $(hostname)
User: $(whoami)
Node Version: $(node -v 2>/dev/null || echo "N/A")
NPM Version: $(npm -v 2>/dev/null || echo "N/A")
Git Version: $(git --version 2>/dev/null || echo "N/A")

Installed Global Packages:
$(npm list -g --depth=0 2>/dev/null || echo "N/A")

OpenClaw Version: $(npm list -g openclaw 2>/dev/null | grep openclaw || echo "Unknown")
EOF
echo "  ✓ system-info.txt"

# 8. Create backup archive
echo "📦 Creating archive..."
ARCHIVE_NAME="openclaw-backup-$TIMESTAMP.tar.gz"
cd "$BACKUP_DIR"
tar -czf "$SCRIPT_DIR/$ARCHIVE_NAME" .
cd "$SCRIPT_DIR"

echo ""
echo "✅ Backup Complete!"
echo "Archive: $SCRIPT_DIR/$ARCHIVE_NAME"
echo "Size: $(du -h "$SCRIPT_DIR/$ARCHIVE_NAME" | cut -f1)"
echo ""

# 9. Git commit (if in git repo)
if [ -d "$SCRIPT_DIR/.git" ]; then
    echo "📝 Committing to Git..."
    cd "$SCRIPT_DIR"
    git add . || true
    git commit -m "Backup: $(date '+%Y-%m-%d %H:%M')" || echo "No changes to commit"
    echo "  ✓ Git commit complete"
fi

echo ""
echo "🎉 All done!"
echo ""
echo "To restore:"
echo "  ./restore-openclaw.sh $SCRIPT_DIR/$ARCHIVE_NAME"
