# OpenClaw Complete Backup & Auto-Setup

## 🚀 Quick Setup

### Option 1: From GitHub Backup
```bash
# Clone backup repo
git clone https://github.com/YOUR_USERNAME/openclaw-backup.git
cd openclaw-backup

# Run auto-setup
./setup-openclaw.sh
```

### Option 2: From Scratch (One Command)
```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/openclaw-backup/main/setup-openclaw.sh | bash
```

### Option 3: Using OpenCode/Codex
Just paste this prompt:
```
/setup-openclaw --from-backup --github-repo YOUR_USERNAME/openclaw-backup
```

---

## What This Backs Up

### 1. Configuration Files
- [x] `openclaw.json` - Main config
- [x] `credentials/` - API keys (encrypted)
- [x] `skills/` - Custom skills
- [x] `memory/` - Long-term memory
- [x] `SOUL.md`, `USER.md`, `AGENTS.md` - Identity files

### 2. Workspace
- [x] All project files
- [x] Scripts and tools
- [x] Custom configurations
- [x] Session history

### 3. System State
- [x] Installed skills
- [x] Cron jobs
- [x] Environment variables
- [x] Node modules

### 4. Data
- [x] Memory files (daily + long-term)
- [x] Analysis reports
- [x] Scraped data
- [x] Generated reports

---

## Files Structure

```
openclaw-backup/
├── setup-openclaw.sh          # Main setup script
├── backup-openclaw.sh         # Backup script
├── restore-openclaw.sh        # Restore script
├── config/
│   ├── openclaw.json          # Main config
│   ├── credentials.env        # Encrypted credentials
│   └── env.template           # Environment template
├── skills/                    # Custom skills
│   ├── skill-1/
│   ├── skill-2/
│   └── ...
├── workspace/                 # Workspace files
│   ├── SOUL.md
│   ├── USER.md
│   ├── AGENTS.md
│   ├── memory/
│   └── scripts/
├── cron/
│   └── openclaw.cron          # Cron jobs
└── README.md                  # This file
```

---

## Usage

### Create Backup
```bash
./backup-openclaw.sh
# or
./backup-openclaw.sh --full  # Include all data
```

### Restore from Backup
```bash
./restore-openclaw.sh
# or
./restore-openclaw.sh --config-only  # Config only, no data
```

### Setup Fresh OpenClaw
```bash
./setup-openclaw.sh
# or
./setup-openclaw.sh --skip-credentials  # Skip credentials setup
```

---

## Automation

### GitHub Actions Auto-Backup
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
      - name: Backup OpenClaw
        run: ./backup-openclaw.sh
      - name: Commit backup
        run: |
          git add .
          git commit -m "Backup: $(date)"
          git push
```

---

## Security

### Encrypted Credentials
- Credentials stored in `.credentials.env.gpg`
- Encrypted with GPG
- Decryption requires passphrase

### Environment Variables
Copy `.env.template` to `.env`:
```bash
GITHUB_TOKEN=your_token
ENCRYPTION_PASSPHRASE=your_passphrase
```

---

## Troubleshooting

### Setup Fails
```bash
# Check prerequisites
./setup-openclaw.sh --check

# Verbose mode
./setup-openclaw.sh --verbose
```

### Restore Issues
```bash
# Validate backup
./restore-openclaw.sh --validate

# Restore specific component
./restore-openclaw.sh --component workspace
```

---

## Next Steps

1. **Initialize Git repo**
   ```bash
   git init
   git remote add origin https://github.com/YOUR_USERNAME/openclaw-backup.git
   ```

2. **First backup**
   ```bash
   ./backup-openclaw.sh --full
   git add .
   git commit -m "Initial backup"
   git push -u origin main
   ```

3. **Setup auto-backup cron**
   ```bash
   ./setup-openclaw.sh --setup-cron
   ```

---

**Made with ❤️ for OpenClaw users**
