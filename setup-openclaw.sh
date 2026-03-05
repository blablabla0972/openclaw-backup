#!/bin/bash
# OpenClaw Complete Setup Script
# One-command setup for OpenClaw from scratch

set -e

echo "🚀 OpenClaw Auto-Setup Script"
echo "============================"
echo "Started: $(date)"
echo ""

# Configuration
OPENCLAW_DIR="${HOME}/.openclaw"
WORKSPACE_DIR="$OPENCLAW_DIR/workspace"
GITHUB_REPO=${GITHUB_REPO:-""}
GITHUB_TOKEN=${GITHUB_TOKEN:-""}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_step() {
    echo -e "${GREEN}==>${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

echo_error() {
    echo -e "${RED}❌${NC} $1"
}

# Check prerequisites
echo_step "Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo_error "Node.js not found. Installing..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi
echo "  ✓ Node.js: $(node -v)"

# Check npm
if ! command -v npm &> /dev/null; then
    echo_error "npm not found. Installing..."
    sudo apt-get install -y npm
fi
echo "  ✓ npm: $(npm -v)"

# Check git
if ! command -v git &> /dev/null; then
    echo_error "git not found. Installing..."
    sudo apt-get install -y git
fi
echo "  ✓ git: $(git --version)"

# Install OpenClaw
echo_step "Installing OpenClaw..."
if command -v openclaw &> /dev/null; then
    echo_warn "OpenClaw already installed. Updating..."
    npm update -g openclaw
else
    npm install -g openclaw
fi
echo "  ✓ OpenClaw installed"

# Clone from GitHub (if repo provided)
if [ -n "$GITHUB_REPO" ]; then
    echo_step "Cloning from GitHub..."
    BACKUP_DIR="$WORKSPACE_DIR/openclaw-backup"
    
    if [ -n "$GITHUB_TOKEN" ]; then
        git clone "https://$GITHUB_TOKEN@github.com/$GITHUB_REPO.git" "$BACKUP_DIR"
    else
        git clone "https://github.com/$GITHUB_REPO.git" "$BACKUP_DIR"
    fi
    
    echo_step "Restoring from backup..."
    cd "$BACKUP_DIR"
    ./restore-openclaw.sh
else
    echo_warn "No GitHub repo specified. Setting up from scratch..."
    
    # Create workspace structure
    mkdir -p "$WORKSPACE_DIR"
    
    # Initialize basic files
    echo_step "Creating basic configuration..."
    
    cat > "$WORKSPACE_DIR/SOUL.md" << 'EOF'
# SOUL.md - Who You Are

## Core Truths
- Be genuinely helpful
- Have opinions
- Be resourceful
- Earn trust
- Blunt honesty

## Vibe
Be the assistant you'd actually want to talk to.
EOF

    cat > "$WORKSPACE_DIR/USER.md" << EOF
# USER.md - About Your Human

## Basic Info
| Field | Value |
|-------|-------|
| Name | User |
| Timezone | UTC |
EOF

    cat > "$WORKSPACE_DIR/AGENTS.md" << 'EOF'
# AGENTS.md - Your Workspace

## First Run
1. Read SOUL.md
2. Read USER.md
3. Read memory files
4. Start helping!
EOF

    mkdir -p "$WORKSPACE_DIR/memory"
    
    cat > "$WORKSPACE_DIR/memory/README.md" << 'EOF'
# Memory Files
Daily and long-term memory stored here.
EOF

fi

# Setup credentials
echo_step "Setting up credentials..."
mkdir -p "$OPENCLAW_DIR/credentials"

if [ ! -f "$OPENCLAW_DIR/credentials/google.env" ]; then
    cat > "$OPENCLAW_DIR/credentials/google.env" << 'EOF'
# Google AI API Key
# Get from: https://makersuite.google.com/app/apikey
GOOGLE_API_KEY=your_key_here
EOF
    echo_warn "Google API key not set. Edit $OPENCLAW_DIR/credentials/google.env"
fi

# Install common skills
echo_step "Installing common skills..."
SKILLS=("weather" "github" "healthcheck")
for skill in "${SKILLS[@}"; do
    if [ ! -d "$OPENCLAW_DIR/skills/$skill" ]; then
        echo "  Installing skill: $skill"
        # openclaw skill install $skill 2>/dev/null || echo_warn "Skill $skill not available"
    fi
done

# Setup cron jobs
echo_step "Setting up cron jobs..."
CRON_JOB="0 3 * * * openclaw gateway healthcheck"
if ! crontab -l | grep -q "healthcheck"; then
    (crontab -l 2>/dev/null | grep -v healthcheck; echo "$CRON_JOB") | crontab -
    echo "  ✓ Cron job added"
else
    echo "  ✓ Cron job already exists"
fi

# Start OpenClaw
echo_step "Starting OpenClaw Gateway..."
if openclaw gateway status &> /dev/null; then
    echo_warn "Gateway already running"
else
    openclaw gateway start
    echo "  ✓ Gateway started"
fi

# Final validation
echo_step "Validating installation..."
if openclaw --version &> /dev/null; then
    echo "  ✓ OpenClaw CLI: OK"
else
    echo_error "OpenClaw CLI: FAILED"
fi

if [ -d "$WORKSPACE_DIR" ]; then
    echo "  ✓ Workspace: OK"
else
    echo_error "Workspace: FAILED"
fi

echo ""
echo "✅ Setup Complete!"
echo ""
echo "Next steps:"
echo "1. Edit credentials: $OPENCLAW_DIR/credentials/google.env"
echo "2. Configure USER.md with your info"
echo "3. Start chatting!"
echo ""
echo "Commands:"
echo "  openclaw gateway status  - Check gateway status"
echo "  openclaw gateway logs    - View logs"
echo "  openclaw --help          - Help"
echo ""
