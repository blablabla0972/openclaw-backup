# Memory & Skills Backup Instructions

## ⚠️ GitHub Secret Scanning Block

GitHub đã block push vì phát hiện secrets (API keys, tokens) trong memory files.

**Giải pháp:** Chỉ backup memory local hoặc dùng private repo với secret scanning disabled.

---

## Option 1: Backup Memory Local (Recommended)

### Backup toàn bộ memory:

```bash
# Tạo backup archive
cd ~/.openclaw/workspace
tar -czf openclaw-memory-backup-$(date +%Y%m%d).tar.gz memory/

# Lưu vào thư mục an toàn
mv openclaw-memory-backup-*.tar.gz ~/backups/
```

### Backup toàn bộ skills:

```bash
cd ~/.openclaw
tar -czf openclaw-skills-backup-$(date +%Y%m%d).tar.gz skills/
mv openclaw-skills-backup-*.tar.gz ~/backups/
```

### Restore khi cần:

```bash
# Restore memory
cd ~/.openclaw/workspace
tar -xzf ~/backups/openclaw-memory-backup-YYYYMMDD.tar.gz

# Restore skills
cd ~/.openclaw
tar -xzf ~/backups/openclaw-skills-backup-YYYYMMDD.tar.gz
```

---

## Option 2: Push to Private Repo (Allow Secrets)

1. **Make repo private:**
   - Go to: https://github.com/blablabla0972/openclaw-backup/settings
   - Scroll to "Danger Zone"
   - Click "Change visibility" → Private

2. **Disable secret scanning:**
   - Settings → Security → Secret scanning
   - Disable for this repo

3. **Force push:**
   ```bash
   cd ~/.openclaw/workspace/openclaw-backup
   git add memory-backup/
   git commit -m "Add memory backup"
   git push --force
   ```

---

## Option 3: Backup Only Safe Files

Chỉ push các files không chứa secrets:

```bash
cd ~/.openclaw/workspace/openclaw-backup

# Add only safe directories
git add scripts/
git add *.sh
git add *.md (excluding memory)
git commit -m "Backup scripts and docs"
git push
```

---

## Current Status

✅ **Pushed to GitHub:**
- Setup scripts (setup-openclaw.sh, etc.)
- Documentation (README, INSTALL, etc.)
- Backup/restore scripts

❌ **Not pushed (contains secrets):**
- memory/ files (contains API keys, tokens)
- Some skills with embedded credentials

---

## Recommendation

**Best practice:**
1. Keep scripts on GitHub (public OK)
2. Keep memory/skills in local backup or encrypted archive
3. Use environment variables for secrets
4. Never commit actual credentials

**For complete backup:**
```bash
# Create encrypted backup
cd ~/.openclaw
tar czf - workspace/memory skills | gpg -c > openclaw-full-backup.gpg

# Store securely (e.g., S3, Google Drive, encrypted USB)
```

---

## Quick Local Backup Script

Create `~/bin/openclaw-backup.sh`:

```bash
#!/bin/bash
BACKUP_DIR=~/backups/openclaw
mkdir -p $BACKUP_DIR
DATE=$(date +%Y%m%d-%H%M)

# Backup memory
tar -czf $BACKUP_DIR/memory-$DATE.tar.gz ~/.openclaw/workspace/memory/

# Backup skills
tar -czf $BACKUP_DIR/skills-$DATE.tar.gz ~/.openclaw/skills/

# Backup config
cp ~/.openclaw/openclaw.json $BACKUP_DIR/config-$DATE.json

echo "Backup complete: $BACKUP_DIR"
```

Run daily/weekly as needed.

---

**Remember:** GitHub is for code, not secrets! 🔐
