# 🚀 Push to GitHub - Step by Step

## Quick Push (3 Commands)

```bash
# 1. Create repo on GitHub.com (name: openclaw-backup)
# Get your repo URL, then:

cd ~/.openclaw/workspace/openclaw-backup
git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git
git push -u origin main
```

## Detailed Steps

### Step 1: Create GitHub Repository

1. Go to: https://github.com/new
2. Repository name: `openclaw-backup`
3. Description: "OpenClaw Complete Backup & Auto-Setup"
4. Visibility: **Private** (recommended) or Public
5. **DO NOT** initialize with README (we already have code)
6. Click "Create repository"

### Step 2: Get Your Repo URL

After creating repo, GitHub will show:
```
git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git
```

Copy this URL!

### Step 3: Add Remote & Push

```bash
# Navigate to backup directory
cd ~/.openclaw/workspace/openclaw-backup

# Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git

# Push to GitHub
git push -u origin main
```

### If Using GitHub Token

If you have 2FA enabled:

```bash
# Create token at: https://github.com/settings/tokens
# Select scopes: repo, workflow

# Use token in URL:
git remote add origin https://YOUR_TOKEN@github.com/YOUR_USERNAME/openclaw-backup.git

# Or store credentials:
git config --global credential.helper store
# Then push (will ask once)
git push -u origin main
```

---

## Verify Push

After pushing, check:

```bash
# View on GitHub
https://github.com/YOUR_USERNAME/openclaw-backup

# Should see:
# - README.md
# - setup-openclaw.sh
# - backup-openclaw.sh
# - restore-openclaw.sh
# - All .md files
```

---

## After Push - Usage

Now anyone can setup OpenClaw with:

```bash
# One command setup
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash

# Or clone and run manually
git clone https://github.com/YOUR_USERNAME/openclaw-backup.git
cd openclaw-backup
./setup-openclaw.sh
```

---

## Setup Auto-Backup (Optional)

After pushing, setup auto-backup:

```bash
# Add GitHub token for auto-push
export GITHUB_TOKEN=ghp_xxx

# Setup cron for daily backup
./setup-openclaw.sh --setup-cron
```

---

## Troubleshooting

### "remote origin already exists"
```bash
git remote set-url origin https://github.com/YOUR_USERNAME/openclaw-backup.git
```

### "permission denied"
```bash
# Use token:
git remote set-url origin https://YOUR_TOKEN@github.com/YOUR_USERNAME/openclaw-backup.git
```

### "no matching remote branch"
```bash
# Force push:
git push -u origin main --force
```

---

## That's It!

Once pushed to GitHub:
- ✅ Backup is on GitHub
- ✅ Can restore from anywhere
- ✅ Auto-backup will update it daily
- ✅ One command to setup everything!

🎉
