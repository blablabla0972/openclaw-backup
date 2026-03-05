# 🎯 PROMPT TO PASTE - Complete OpenClaw Setup

## Copy This Entire Prompt

Paste this in OpenCode, Codex, or any AI coding assistant:

---

````
I want to setup OpenClaw from my GitHub backup and have everything automated.

Please execute these steps:

1. CHECK IF OPENCLAW IS INSTALLED
   - If not installed: npm install -g openclaw
   - If installed: update to latest version
   - Verify: openclaw --version

2. CLONE MY BACKUP REPOSITORY
   - Repository: https://github.com/YOUR_USERNAME/openclaw-backup
   - Clone to: ~/.openclaw/workspace/openclaw-backup
   - If repo doesn't exist, create it with basic structure

3. RESTORE EVERYTHING
   - Run: ./restore-openclaw.sh
   - This should restore:
     ✓ openclaw.json (configuration)
     ✓ credentials/ (API keys, encrypted)
     ✓ skills/ (all custom skills)
     ✓ workspace/ (all project files)
     ✓ memory/ (daily + long-term memory)
     ✓ cron jobs (scheduled tasks)

4. VALIDATE INSTALLATION
   - Check gateway status: openclaw gateway status
   - Verify workspace exists: ls ~/.openclaw/workspace/
   - Test a simple command: openclaw --help

5. SETUP AUTO-BACKUP
   - Install cron job for daily backup at 3 AM
   - Command: 0 3 * * * cd ~/.openclaw/workspace/openclaw-backup && ./backup-openclaw.sh --auto-commit
   - Verify cron: crontab -l

6. REPORT STATUS
   Show me:
   - ✅ What was installed/restored
   - ⚠️  Any warnings or errors
   - 📊 Current OpenClaw status
   - 📁 Location of restored files
   - 🔄 Next backup schedule
   - 📝 Any manual steps needed

Expected output structure:
```
✅ OpenClaw Setup Complete!

Restored:
  ✓ Configuration: ~/.openclaw/openclaw.json
  ✓ Credentials: ~/.openclaw/credentials/
  ✓ Skills: X skills restored
  ✓ Workspace: X files restored
  ✓ Memory: X files restored
  ✓ Cron: Daily backup scheduled

Gateway Status: Running/Stopped
Next Backup: 2026-03-06 03:00:00

Files Location:
  Config: ~/.openclaw/openclaw.json
  Workspace: ~/.openclaw/workspace/
  Backups: ~/.openclaw/workspace/openclaw-backup/

Next Steps:
  1. Check credentials: cat ~/.openclaw/credentials/*.env
  2. Start chatting: openclaw chat
  3. View docs: ~/.openclaw/workspace/openclaw-backup/ONE-COMMAND.md
```

If any step fails:
- Log the error
- Continue with remaining steps
- Provide troubleshooting guide at the end
````

---

## Even Shorter Version

If you want an even shorter prompt:

````
/setup-openclaw --from-backup --github-repo YOUR_USERNAME/openclaw-backup --auto-restore --setup-cron
````

---

## What Happens

This single prompt will:
1. ✅ Install/update OpenClaw
2. ✅ Clone your backup from GitHub
3. ✅ Restore ALL settings, skills, workspace, memory
4. ✅ Setup automatic daily backups
5. ✅ Validate everything works
6. ✅ Report complete status

**One prompt. Complete setup. Everything automated.**

---

## Files Created

After running this, you'll have:

``
~/.openclaw/
├── openclaw.json (config)
├── credentials/ (API keys)
├── skills/ (custom skills)
├── workspace/
│   ├── SOUL.md
│   ├── USER.md
│   ├── AGENTS.md
│   ├── memory/
│   ├── openclaw-backup/ (backup scripts)
│   └── ...
└── logs/
```

---

## For Future Use

Save this prompt! Next time you need to setup OpenClaw:

1. **On new machine**: Just paste the prompt
2. **After crash**: Just paste the prompt
3. **Want to restore**: Just paste the prompt

Everything is automated. Everything is backed up. Everything is ready.

🎉
