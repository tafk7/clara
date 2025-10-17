#!/bin/bash
# Clara Framework - Claude Code Config Update Script
# Updates ~/.claude/ with latest commands and global config

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
COMMANDS_ONLY=false

show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -c, --commands-only    Update only commands, skip global CLAUDE.md"
    echo "  -h, --help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Update both commands and global config"
    echo "  $0 -c                 # Update only commands"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--commands-only)
            COMMANDS_ONLY=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            show_usage
            exit 1
            ;;
    esac
done

# Get timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR=".backups/$TIMESTAMP"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Clara Framework Config Updater       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

if [ "$COMMANDS_ONLY" = true ]; then
    echo -e "${YELLOW}Mode: Commands only${NC}"
    echo ""
fi

# Verify we're in the right directory
if [ ! -d "commands" ] || [ ! -f "global-CLAUDE.md" ]; then
    echo -e "${RED}Error: Must run from clara repository root${NC}"
    echo "Expected to find: commands/ and global-CLAUDE.md"
    exit 1
fi

# Create backup directory
echo -e "${YELLOW}→ Creating backup directory: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Backup existing config
BACKUP_COUNT=0
if [ -d ~/.claude/commands ]; then
    echo -e "${YELLOW}→ Backing up existing commands...${NC}"
    cp -r ~/.claude/commands "$BACKUP_DIR/"
    COMMAND_COUNT=$(find "$BACKUP_DIR/commands" -name '*.md' 2>/dev/null | wc -l)
    echo -e "  ${GREEN}✓${NC} Backed up ~/.claude/commands/ ($COMMAND_COUNT files)"
    BACKUP_COUNT=$((BACKUP_COUNT + 1))
fi

if [ "$COMMANDS_ONLY" = false ] && [ -f ~/.claude/CLAUDE.md ]; then
    echo -e "${YELLOW}→ Backing up existing CLAUDE.md...${NC}"
    cp ~/.claude/CLAUDE.md "$BACKUP_DIR/"
    echo -e "  ${GREEN}✓${NC} Backed up ~/.claude/CLAUDE.md"
    BACKUP_COUNT=$((BACKUP_COUNT + 1))
fi

if [ $BACKUP_COUNT -eq 0 ]; then
    echo -e "  ${BLUE}ℹ${NC} No existing config found to backup"
fi

echo ""

# Remove old commands directory
if [ -d ~/.claude/commands ]; then
    echo -e "${YELLOW}→ Removing old commands directory...${NC}"
    rm -rf ~/.claude/commands
    echo -e "  ${GREEN}✓${NC} Removed"
fi

# Install new config
echo -e "${GREEN}→ Installing new configuration...${NC}"

# Ensure ~/.claude exists
mkdir -p ~/.claude

# Copy commands
echo "  • Copying commands/ → ~/.claude/commands/"
cp -r commands ~/.claude/

# Copy and rename global config (unless commands-only mode)
if [ "$COMMANDS_ONLY" = false ]; then
    echo "  • Copying global-CLAUDE.md → ~/.claude/CLAUDE.md"
    cp global-CLAUDE.md ~/.claude/CLAUDE.md
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Configuration update complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [ $BACKUP_COUNT -gt 0 ]; then
    echo -e "${BLUE}Backup:${NC} $BACKUP_DIR"
    echo ""
fi

# Count installed commands
NEW_CMD_COUNT=$(find ~/.claude/commands -name '*.md' 2>/dev/null | wc -l)
echo -e "${BLUE}Updated files:${NC}"
echo "  • ~/.claude/commands/ ($NEW_CMD_COUNT commands)"
if [ "$COMMANDS_ONLY" = false ]; then
    echo "  • ~/.claude/CLAUDE.md"
fi
echo ""

# Show command categories
echo -e "${BLUE}Command categories:${NC}"
for category in ~/.claude/commands/*/; do
    if [ -d "$category" ]; then
        cat_name=$(basename "$category")
        cat_count=$(find "$category" -name '*.md' | wc -l)
        echo "  • $cat_name: $cat_count commands"
    fi
done

echo ""
echo -e "${GREEN}Arete.${NC}"
