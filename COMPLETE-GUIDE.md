# 🎯 OpenClaw Complete Backup & Auto-Setup Guide

## TL;DR - Just One Command!

Paste this in **OpenCode**, **Codex**, or any AI coding assistant:

```
Setup my OpenClaw from backup:
- GitHub: YOUR_USERNAME/openclaw-backup
- Auto-restore everything
- Setup daily auto-backup
```

Or run directly:
```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash
```

---

## 📦 What's Included

### Backup Scripts
- ✅ `backup-openclaw.sh` - Complete backup to GitHub
- ✅ `restore-openclaw.sh` - Restore from backup
- ✅ `setup-openclaw.sh` - Fresh install + restore
- ✅ `marathon-status.sh` - Check backup status

### Documentation
- ✅ `README.md` - Overview
- ✅ `INSTALL.md` - Installation guide
- ✅ `QUICK-START.md` - Quick start guide
- ✅ `COMPLETE-GUIDE.md` - This file
- ✅ `opencode-prompt.txt` - OpenCode prompt

### What Gets Backed Up
- ✅ OpenClaw configuration
- ✅ API credentials (encrypted)
- ✅ Custom skills
- ✅ Workspace files
- ✅ Memory (all files)
- ✅ Cron jobs
- ✅ System info

---

## 🚀 Usage Scenarios

### Scenario 1: Fresh Install on New Machine

```bash
# Step 1: Install OpenClaw
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash

# Step 2: Done! Everything restored from GitHub.
```

### Scenario 2: Regular Backup

```bash
# Daily auto-backup (via cron)
# Or manual:
cd ~/.openclaw/workspace/openclaw-backup
./backup-openclaw.sh
git add .
git commit -m "Daily backup"
git push
```

### Scenario 3: Restore After Crash

```bash
# Just run setup again - it will restore from GitHub
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash
```

### Scenario 4: Migrate to New Machine

```bash
# Old machine: Backup to GitHub
cd ~/.openclaw/workspace/openclaw-backup
./backup-openclaw.sh
git push

# New machine: Setup from GitHub
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash
```

---

## 📋 Detailed Commands

### Backup Commands

```bash
# Full backup
./backup-openclaw.sh --full

# Backup config only
./backup-openclaw.sh --config-only

# Backup workspace only
./backup-openclaw.sh --workspace-only

# With auto-commit to git
./backup-openclaw.sh --auto-commit
```

### Restore Commands

```bash
# Latest backup
./restore-openclaw.sh

# Specific backup
./restore-openclaw.sh openclaw-backup-20260305-153000.tar.gz

# Config only
./restore-openclaw.sh --config-only

# Validate only
./restore-openclaw.sh --validate
```

### Setup Commands

```bash
# Fresh setup
./setup-openclaw.sh --fresh

# From GitHub backup
./setup-openclaw.sh --from-github YOUR_USERNAME/openclaw-backup

# Skip credentials
./setup-openclaw.sh --skip-credentials

# Verbose mode
./setup-openclaw.sh --verbose
```

---

## 🔧 Automation

### Daily Auto-Backup (Cron)

```bash
# Add to crontab (runs at 3 AM daily)
0 3 * * * cd ~/.openclaw/workspace/openclaw-backup && ./backup-openclaw.sh --auto-commit >> backup.log 2>&1
```

### GitHub Actions (Auto-Build)

Create `.github/workflows/backup.yml`:

```yaml
name: OpenClaw Backup

on:
  schedule:
    - cron: '0 3 * * *'  # Daily at 3 AM
  workflow_dispatch:

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
      
      - name: Install OpenClaw
        run: npm install -g openclaw
      
      - name: Run Backup
        run: ./backup-openclaw.sh
      
      - name: Commit Changes
        run: |
          git add .
          git commit -m "Backup: $(date '+%Y-%m-%d %H:%M')"
          git push
        env:
          GIT_AUTHOR_NAME: OpenClaw Bot
          GIT_AUTHOR_EMAIL: bot@users.noreply.github.com
```

---

## 🔒 Security

### Encrypted Credentials

```bash
# Encrypt sensitive data
gpg -c credentials.env
# Creates: credentials.env.gpg

# Decrypt when needed
gpg -d credentials.env.gpg > credentials.env
```

### GitHub Token Security

```bash
# Create token with repo scope
# https://github.com/settings/tokens

# Store securely
git credential-cache store
# Or use environment variable
export GITHUB_TOKEN=ghp_xxx

# Never commit tokens to git!
echo "*.env" >> .gitignore
```

---

## 📊 Backup Structure

```
openclaw-backup/
├── README.md
├── INSTALL.md
├── QUICK-START.md
├── COMPLETE-GUIDE.md
├── setup-openclaw.sh
├── backup-openclaw.sh
├── restore-openclaw.sh
├── marathon-status.sh
├── opencode-prompt.txt
│
├── config/
│   └── openclaw.json
│
├── credentials/
│   ├── google.env
│   └── brave.env
│
├── skills/
│   ├── skill-1/
│   ├── skill-2/
│   └── ...
│
├── workspace/
│   ├── SOUL.md
│   ├── USER.md
│   ├── AGENTS.md
│   ├── memory/
│   ├── scripts/
│   └── ...
│
├── memory/
│   ├── daily-files/
│   └── long-term/
│
├── cron/
│   └── openclaw.cron
│
└── backup/
    └── *.tar.gz (archives)
```

---

## 🐛 Troubleshooting

### Common Issues

**1. Setup fails with permission error**
```bash
# Fix permissions
chmod +x ~/.openclaw/workspace/openclaw-backup/*.sh
sudo chown -R $(whoami) ~/.openclaw
```

**2. Git push fails**
```bash
# Check token
git remote -v

# Update token
git remote set-url origin https://YOUR_TOKEN@github.com/USER/REPO.git
```

**3. Backup too large**
```bash
# Exclude large files
./backup-openclaw.sh --exclude-large

# Or exclude specific dirs
./backup-openclaw.sh --exclude node_modules,camoufox-env
```

**4. Restore fails**
```bash
# Validate backup
./restore-openclaw.sh --validate

# Try different backup
ls -la openclaw-backup-*.tar.gz
./restore-openclaw.sh openclaw-backup-20260305-153000.tar.gz
```

---

## 📈 Best Practices

1. **Backup Daily**: Set cron for 3 AM daily
2. **Commit Often**: Git commit after each significant change
3. **Encrypt Secrets**: Never commit plain credentials
4. **Test Restore**: Periodically test restore process
5. **Version Tags**: Tag major backups with git tags

---

## 🎯 Next Steps

1. **Setup GitHub repo** (one time):
   ```bash
   cd ~/.openclaw/workspace/openclaw-backup
   git init
   git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git
   git add .
   git commit -m "Initial setup"
   git push -u origin main
   ```

2. **First backup**:
   ```bash
   ./backup-openclaw.sh --full
   git push
   ```

3. **Setup auto-backup**:
   ```bash
   ./setup-openclaw.sh --setup-cron
   ```

4. **Verify**:
   ```bash
   ./marathon-status.sh
   ```

---

**🎉 You're all set! One command to backup/restore everything!**
