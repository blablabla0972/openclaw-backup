# 🚀 One-Command OpenClaw Setup & Backup

## Quick Start (Choose One)

### Option 1: From GitHub Backup (Recommended)

```bash
# Just paste this ONE command:
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash -s -- --from-github YOUR_USERNAME/openclaw-backup
```

### Option 2: Fresh Install

```bash
# One command for fresh setup:
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash
```

### Option 3: Using OpenCode/Codex

Just paste this prompt:

```
/setup-openclaw --auto --github-repo YOUR_USERNAME/openclaw-backup
```

Or even simpler:

```
Setup my OpenClaw from backup: YOUR_USERNAME/openclaw-backup
```

---

## What Gets Backed Up

### ✅ Complete System State
- [x] OpenClaw configuration (`openclaw.json`)
- [x] API credentials (encrypted)
- [x] Custom skills
- [x] Workspace files
- [x] Memory (daily + long-term)
- [x] Cron jobs
- [x] Environment variables
- [x] System info

### ✅ Project Files
- All analysis reports
- Scraped data
- Generated content
- Custom scripts
- Configuration files

---

## Detailed Setup Process

### Step 1: Clone Backup Repository

```bash
git clone https://github.com/YOUR_USERNAME/openclaw-backup.git
cd openclaw-backup
```

### Step 2: Run Setup

```bash
# Full setup with restore
./setup-openclaw.sh

# Or restore from specific backup
./restore-openclaw.sh openclaw-backup-20260305-153000.tar.gz
```

### Step 3: Verify

```bash
openclaw gateway status
cat ~/.openclaw/workspace/SOUL.md
```

---

## Automated Backup

### Daily Auto-Backup

Add to crontab:

```bash
0 3 * * * /path/to/openclaw-backup/backup-openclaw.sh --auto-commit
```

### GitHub Actions

Create `.github/workflows/backup.yml`:

```yaml
name: OpenClaw Daily Backup

on:
  schedule:
    - cron: '0 3 * * *'  # Daily at 3 AM
  workflow_dispatch:

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '20'
      
      - name: Install OpenClaw
        run: npm install -g openclaw
      
      - name: Run Backup
        run: ./backup-openclaw.sh
      
      - name: Commit Backup
        run: |
          git add .
          git commit -m "Backup: $(date '+%Y-%m-%d %H:%M')"
          git push
        env:
          GIT_AUTHOR_NAME: OpenClaw Bot
          GIT_AUTHOR_EMAIL: bot@users.noreply.github.com
          GIT_COMMITTER_NAME: OpenClaw Bot
          GIT_COMMITTER_EMAIL: bot@users.noreply.github.com
```

---

## Security

### Encrypted Credentials

```bash
# Encrypt credentials
gpg -c credentials.env
# Output: credentials.env.gpg

# Decrypt when needed
gpg -d credentials.env.gpg > credentials.env
```

### Environment Variables

Create `.env`:

```bash
GITHUB_TOKEN=ghp_your_token_here
ENCRYPTION_PASSPHRASE=your_secret_passphrase
GITHUB_REPO=YOUR_USERNAME/openclaw-backup
```

---

## Troubleshooting

### Setup Fails

```bash
# Check prerequisites
./setup-openclaw.sh --check

# Verbose mode
./setup-openclaw.sh --verbose

# Clean install
rm -rf ~/.openclaw
./setup-openclaw.sh --fresh
```

### Backup Fails

```bash
# Validate backup
./backup-openclaw.sh --validate

# Backup specific component
./backup-openclaw.sh --component workspace

# Skip large files
./backup-openclaw.sh --skip-large-files
```

### Restore Fails

```bash
# List available backups
ls -la openclaw-backup-*.tar.gz

# Restore specific component
./restore-openclaw.sh --component workspace

# Dry run
./restore-openclaw.sh --dry-run
```

---

## Advanced Usage

### Custom Backup Location

```bash
./backup-openclaw.sh --output /path/to/backup/location
```

### Selective Restore

```bash
# Restore only workspace
./restore-openclaw.sh --component workspace

# Restore only skills
./restore-openclaw.sh --component skills

# Restore config only
./restore-openclaw.sh --component config
```

### Migration to New Machine

```bash
# On old machine:
./backup-openclaw.sh --full
git push

# On new machine:
./setup-openclaw.sh --from-github YOUR_USERNAME/openclaw-backup
```

---

## File Structure

```
openclaw-backup/
├── README.md                  # This file
├── INSTALL.md                 # Installation guide
├── setup-openclaw.sh          # Setup script
├── backup-openclaw.sh         # Backup script
├── restore-openclaw.sh        # Restore script
├── config/
│   └── openclaw.json         # Main config
├── skills/                    # Custom skills
├── workspace/                 # Workspace files
├── memory/                    # Memory files
└── cron/                      # Cron jobs
```

---

## Support

For issues or questions:
1. Check logs: `~/.openclaw/logs/`
2. Run validation: `./setup-openclaw.sh --check`
3. Review docs: `/usr/lib/node_modules/openclaw/docs`

---

**Made with ❤️ for seamless OpenClaw setup & backup**
