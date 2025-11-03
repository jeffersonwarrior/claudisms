# Claudeisms

Claude Code plugin enforcing operational guidelines and terse responses.

## Features

- Terse, code-first responses (1-2 sentences max)
- Sequential execution protocols
- No destructive operations without confirmation
- Minimal documentation (200 words max for .md files)
- Test after every task
- RCA after 2+ revisits
- No emoji, no production claims
- Script reuse over recreation

## Installation

### Via Claude Code Marketplace (Recommended)

1. Run `/plugin` in Claude Code
2. Add marketplace: `jeffersonwarrior/claudisms`
3. Install the plugin
4. Enable in settings (or edit `~/.claude/settings.json`):
```json
"enabledPlugins": {
  "claudeisms@claudisms": true
}
```

### Manual Installation

```bash
cd ~/.claude/plugins
git clone https://github.com/jeffersonwarrior/claudisms.git
```

Then restart Claude Code and enable hooks in Settings → Plugins → Claudisms

## Hooks

- **SessionStart**: Activates core guidelines
- **BeforeToolUse(Write)**: Limits .md files to 200 words

## Slash Commands

### Settings Management

**View current settings:**
```
/claudisms-settings
```

**Set individual settings:**
```
/claudisms-settings set terse_mode off
/claudisms-settings set doc_limits exclude
/claudisms-settings set tmp_location pwd
```

**Manage file exclusions:**
```
/claudisms-settings exclude "**/*PLANNING*.md"
/claudisms-settings include CLAUDE.md
```

**Reload settings:**
```
/claudisms-reload
```

**Show help:**
```
/claudisms-settings help
```

### Settings Reference

| Setting | Values | Description |
|---------|--------|-------------|
| `terse_mode` | on, off | Enable terse responses (1-2 sentences) |
| `doc_limits` | on, off, exclude | Limit .md files to 200 words |
| `destructive_guard` | on, off, exclude | Block destructive operations |
| `sequential_only` | on, off | Enforce sequential execution |
| `tmp_location` | pwd, system | Temp directory location (pwd for session isolation) |
| `debug_logging` | on, off | Enable debug logging |
| `excluded_files` | patterns | Comma-separated file patterns to exclude |

### Pattern Matching

File exclusion patterns support:
- **Exact match**: `CLAUDE.md` matches files ending with CLAUDE.md
- **Wildcards**: `*.md` matches any .md file
- **Recursive glob**: `**/*PLANNING*.md` matches PLANNING.md files in any subdirectory

### Common Use Cases

**Allow detailed documentation:**
```
/claudisms-settings set doc_limits off
# Write detailed documentation
/claudisms-settings set doc_limits on
```

**Exclude planning files from 200-word limit:**
```
/claudisms-settings exclude "PLANNING.md"
/claudisms-settings set doc_limits exclude
```

**Enable session isolation:**
```
/claudisms-settings set tmp_location pwd
```
This creates `${PWD}/tmp/` for each session, preventing log file collisions between multiple Claude Code instances.

## Core Principles

- Sequential execution only - no weeks, numerical order
- No cost considerations - AI handles everything
- Terse responses - less is more
- Test after every task
- No database/folder deletion without confirmation
- No production pushes without confirmation
- Current versions only
- Ask for clarification when irrational
- Never blame user
- RCA after 2+ revisits

## Author

Jefferson Warrior - [GitHub](https://github.com/jeffersonwarrior)

## License

GPL v3

---

## Uninstallation

Removing the plugin from the marketplace does not clean up all configuration. Use the included uninstaller script:

```bash
# Remove this plugin
~/claudisms/claude-plugin-uninstall.sh claudeisms@claudisms

# Remove all plugins
~/claudisms/claude-plugin-uninstall.sh --all

# Check plugin status
~/claudisms/claude-plugin-uninstall.sh
```

The uninstaller:
- Creates automatic backups before removal
- Cleans `~/.claude/plugins/installed_plugins.json`
- Removes plugin files from `~/.claude/plugins/marketplaces/`
- Detects and reports broken plugins (missing files)

## Troubleshooting

**Marketplace naming:** Use `jeffersonwarrior/claudisms` when adding. Plugin name is `claudeisms`, marketplace is `claudisms`, settings show `claudeisms@claudisms` - this is correct.

**Path requirements:** All manifest paths must start with `./` and resolve from plugin root. Example: `.claude-plugin/plugin.json` uses `"hooks": "./hooks.json"` not `"../../hooks.json"`.
