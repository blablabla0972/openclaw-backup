# 🎯 ONE COMMAND - Complete OpenClaw Setup & Backup

## The Only Command You Need

Paste this in **OpenCode**, **Codex**, or your AI assistant:

```
Setup OpenClaw from my backup at: YOUR_USERNAME/openclaw-backup
- Install if needed
- Restore everything (config, skills, workspace, memory)
- Setup auto-backup to GitHub daily
- Validate installation
```

## That's It! ✨

The AI will:
1. ✅ Install OpenClaw (if needed)
2. ✅ Clone your backup repo
3. ✅ Restore ALL settings
4. ✅ Restore ALL skills
5. ✅ Restore ALL workspace files
6. ✅ Restore ALL memory
7. ✅ Setup daily auto-backup
8. ✅ Validate everything works

---

## Alternative: Direct Script

If you prefer running script directly:

```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash -s -- --from-github YOUR_USERNAME/openclaw-backup
```

---

## What Gets Restored

| Component | Status |
|-----------|--------|
| OpenClaw Config | ✅ Restored |
| API Credentials | ✅ Restored (encrypted) |
| Custom Skills | ✅ All installed |
| Workspace Files | ✅ All files |
| Memory (Daily) | ✅ All files |
| Memory (Long-term) | ✅ All files |
| Cron Jobs | ✅ Scheduled |
| Auto-Backup | ✅ Configured |

---

## After Setup

### Check Status
```bash
openclaw gateway status
```

### View Restored Files
```bash
ls -la ~/.openclaw/workspace/
cat ~/.openclaw/workspace/SOUL.md
```

### Test It Works
```bash
openclaw chat
# Type: "Hello, test message"
```

---

## For Future You

### Daily Usage
Just use OpenClaw normally. Auto-backup runs daily at 3 AM.

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
./marathon-status.sh
```

---

## If Something Goes Wrong

### Complete Reset
```bash
# Remove everything
rm -rf ~/.openclaw

# Fresh setup from GitHub
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash
```

### Just Restore Config
```bash
./restore-openclaw.sh --config-only
```

### Just Restore Workspace
```bash
./restore-openclaw.sh --workspace-only
```

---

## GitHub Setup (One Time Only)

First time only, setup GitHub repo:

```bash
# 1. Create repo on github.com (name: openclaw-backup)

# 2. Initialize local repo
cd ~/.openclaw/workspace/openclaw-backup
git init
git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git

# 3. First backup
./backup-openclaw.sh --full
git add .
git commit -m "Initial backup"
git push -u origin main

# Done! Future backups auto-commit
```

---

## That's Really It!

**One command** to setup everything.
**One command** to restore everything.
**Auto-backup** runs daily.

No more manual configuration!
No more lost settings!
No more "how do I setup OpenClaw again?"

Just:
```
Setup OpenClaw from my backup: YOUR_USERNAME/openclaw-backup
```

🎉
