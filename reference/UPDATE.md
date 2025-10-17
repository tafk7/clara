# Clara Framework - Config Update Guide

This guide explains how to update your Claude Code configuration with the latest Clara Framework commands and global config.

## Quick Start

Run the update script from the clara repository root:

```bash
# Update both commands and global config
./update-config.sh

# Update only commands (preserve existing CLAUDE.md)
./update-config.sh -c
```

### Options

- **`-c, --commands-only`** - Update only the commands directory, skip global CLAUDE.md
- **`-h, --help`** - Show help message

### Full Update

```bash
./update-config.sh
```

This will:
1. Create a timestamped backup in `.backups/YYYYMMDD_HHMMSS/`
2. Backup your existing `~/.claude/commands/` and `~/.claude/CLAUDE.md`
3. Install the latest commands and global config
4. Show a summary of what was updated

### Commands-Only Update

```bash
./update-config.sh --commands-only
```

This will:
1. Create a timestamped backup in `.backups/YYYYMMDD_HHMMSS/`
2. Backup your existing `~/.claude/commands/`
3. Install only the latest commands (preserves `~/.claude/CLAUDE.md`)
4. Show a summary of what was updated

**Use this when:** You've customized your global CLAUDE.md and only want to update slash commands.

## One-Liner Alternative

If you prefer a single command without the script:

**Full update (commands + global config):**
```bash
BACKUP=".backups/$(date +%Y%m%d_%H%M%S)" && \
mkdir -p "$BACKUP" && \
[ -d ~/.claude/commands ] && cp -r ~/.claude/commands "$BACKUP/" && \
[ -f ~/.claude/CLAUDE.md ] && cp ~/.claude/CLAUDE.md "$BACKUP/" && \
rm -rf ~/.claude/commands && \
mkdir -p ~/.claude && \
cp -r commands ~/.claude/ && \
cp global-CLAUDE.md ~/.claude/CLAUDE.md && \
echo "✓ Config updated. Backup: $BACKUP"
```

**Commands-only update:**
```bash
BACKUP=".backups/$(date +%Y%m%d_%H%M%S)" && \
mkdir -p "$BACKUP" && \
[ -d ~/.claude/commands ] && cp -r ~/.claude/commands "$BACKUP/" && \
rm -rf ~/.claude/commands && \
mkdir -p ~/.claude && \
cp -r commands ~/.claude/ && \
echo "✓ Commands updated. Backup: $BACKUP"
```

## What Gets Updated

### Full Update (default)

**Installed to `~/.claude/`:**
- `commands/` - All slash commands (analysis, arete, artifacts, workflow, git)
- `CLAUDE.md` - Global Arete philosophy and framework instructions

**Backed up to `.backups/[timestamp]/`:**
- Previous `commands/` directory
- Previous `CLAUDE.md` file

### Commands-Only Update (`-c` flag)

**Installed to `~/.claude/`:**
- `commands/` - All slash commands (analysis, arete, artifacts, workflow, git)

**Backed up to `.backups/[timestamp]/`:**
- Previous `commands/` directory

**Preserved:**
- Existing `~/.claude/CLAUDE.md` (not modified)

## Backup Management

Backups are stored in `.backups/` with timestamps. To clean up old backups:

```bash
# List all backups
ls -lh .backups/

# Remove backups older than 30 days
find .backups -type d -mtime +30 -exec rm -rf {} \;

# Remove a specific backup
rm -rf .backups/20251016_123456
```

## Restoring from Backup

To restore a previous configuration:

```bash
BACKUP=".backups/20251016_123456"  # Use your backup timestamp

# Restore commands
rm -rf ~/.claude/commands
cp -r "$BACKUP/commands" ~/.claude/

# Restore CLAUDE.md
cp "$BACKUP/CLAUDE.md" ~/.claude/
```

## Verification

After updating, verify the installation:

```bash
# Check commands are installed
ls ~/.claude/commands/

# Count total commands
find ~/.claude/commands -name '*.md' | wc -l

# Verify global config
head -5 ~/.claude/CLAUDE.md
```

## Troubleshooting

**Script fails with "Must run from clara repository root":**
- Ensure you're in the directory containing `commands/` and `global-CLAUDE.md`
- Run `pwd` to check your current directory

**Permission denied:**
- Make script executable: `chmod +x update-config.sh`
- Or run with bash: `bash update-config.sh`

**Want to preview changes without installing:**
- Compare directories: `diff -r commands ~/.claude/commands`
- Compare config: `diff global-CLAUDE.md ~/.claude/CLAUDE.md`

## Git Integration

To track when you last updated your Claude config:

```bash
# After updating, commit the timestamp
echo "$(date): Updated Claude config" >> .backups/update-log.txt
git add .backups/update-log.txt
git commit -m "Logged config update"
```

Arete.
