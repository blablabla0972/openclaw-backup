# 🚀 Quick Start - One Command Setup

## Paste This in OpenCode/Codex

### Option 1: From GitHub Backup (Recommended)

```
Setup OpenClaw from my backup:
1. Install OpenClaw if needed
2. Clone https://github.com/YOUR_USERNAME/openclaw-backup
3. Run restore-openclaw.sh
4. Validate installation
5. Setup auto-backup cron
```

### Option 2: Complete Script

```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash -s -- --from-github YOUR_USERNAME/openclaw-backup
```

### Option 3: Using OpenCode Commands

```
/setup-openclaw \
  --from-backup \
  --github-repo YOUR_USERNAME/openclaw-backup \
  --auto-restore \
  --setup-cron
```

---

## What This Does

1. ✅ **Installs OpenClaw** (if not installed)
2. ✅ **Clones backup repo** from GitHub
3. ✅ **Restores everything**:
   - Configuration
   - Credentials
   - Skills
   - Workspace files
   - Memory
   - Cron jobs
4. ✅ **Validates installation**
5. ✅ **Sets up auto-backup**

---

## After Setup

### Check Status
```bash
openclaw gateway status
```

### View Logs
```bash
openclaw gateway logs
```

### Start Chatting
```bash
openclaw chat
```

---

## Backup Commands

### Manual Backup
```bash
cd ~/.openclaw/workspace/openclaw-backup
./backup-openclaw.sh
```

### Manual Restore
```bash
cd ~/.openclaw/workspace/openclaw-backup
./restore-openclaw.sh
```

### Check Backup Status
```bash
ls -la ~/.openclaw/workspace/openclaw-backup/openclaw-backup-*.tar.gz
```

---

## GitHub Setup (One Time)

1. **Create GitHub repo:**
   ```bash
   # Create repo on github.com
   # Then:
   cd ~/.openclaw/workspace/openclaw-backup
   git init
   git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git
   git add .
   git commit -m "Initial backup"
   git push -u origin main
   ```

2. **Setup GitHub token:**
   ```bash
   # Create token at: https://github.com/settings/tokens
   # Add to ~/.gitconfig:
   [credential]
     helper = store
   ```

3. **Auto-backup cron:**
   ```bash
   # Runs daily at 3 AM
   0 3 * * * cd ~/.openclaw/workspace/openclaw-backup && ./backup-openclaw.sh --auto-commit
   ```

---

## Troubleshooting

### If Setup Fails
```bash
# Check what's wrong
./setup-openclaw.sh --check

# Verbose mode
./setup-openclaw.sh --verbose

# Clean install
rm -rf ~/.openclaw
./setup-openclaw.sh --fresh
```

### If Restore Fails
```bash
# List backups
ls -la openclaw-backup-*.tar.gz

# Try different backup
./restore-openclaw.sh openclaw-backup-20260305-153000.tar.gz

# Restore specific component
./restore-openclaw.sh --component workspace
```

### If GitHub Push Fails
```bash
# Check token
git remote -v

# Update token
git remote set-url origin https://YOUR_TOKEN@github.com/YOUR_USERNAME/openclaw-backup.git
```

---

## File Locations

| Component | Location |
|-----------|----------|
| OpenClaw Config | `~/.openclaw/openclaw.json` |
| Credentials | `~/.openclaw/credentials/` |
| Skills | `~/.openclaw/skills/` |
| Workspace | `~/.openclaw/workspace/` |
| Memory | `~/.openclaw/workspace/memory/` |
| Backup Scripts | `~/.openclaw/workspace/openclaw-backup/` |
| Cron Jobs | `crontab -l` |

---

## Next Steps After Setup

1. ✅ **Verify installation**: `openclaw gateway status`
2. ✅ **Check credentials**: `cat ~/.openclaw/credentials/*.env`
3. ✅ **Test a skill**: `openclaw skill test weather`
4. ✅ **Setup auto-backup**: `./setup-openclaw.sh --setup-cron`
5. ✅ **Start using!**: `openclaw chat`

---

**That's it! One command to setup everything! 🎉**
