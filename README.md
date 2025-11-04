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
- Prefer fd/rg over find/grep when available

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
| `terse_mode` | on, off | **Terse responses:** Injects guidelines for 1-2 sentence responses, code-first output, no preamble |
| `doc_limits` | on, off, exclude | **Documentation limits:** Enforces 200-word max on README/SETUP files. `off`=disabled, `on`=all files, `exclude`=uses `excluded_files` list |
| `destructive_guard` | on, off, exclude | **Destructive operation protection:** Blocks `rm -rf`, `git push`, `DROP TABLE`, `DELETE FROM`, `TRUNCATE`. Requires user confirmation. `exclude`=uses pattern matching |
| `sequential_only` | on, off | **Sequential execution:** Enforces numerical task ordering, no parallel execution or week-based planning |
| `tmp_location` | pwd, system | **Log directory:** `pwd`=creates `${PWD}/tmp` for session isolation, `system`=uses `/tmp` (shared across sessions) |
| `debug_logging` | on, off | **Debug mode:** Enables hook execution logs to `${tmp_location}/hook-env-*.log` files for troubleshooting |
| `excluded_files` | patterns | **File exclusions:** Comma-separated patterns. Files matching these patterns bypass `doc_limits` hook. Example: `CLAUDE.md,**/*PLANNING*.md` |

**How settings work:**

Settings are stored in `.claudisms-settings` file (key=value format). Hooks read this file at execution time via `lib/settings-loader.sh`. Changes require `/claudisms-reload` or Claude Code restart to take effect.

**Hook behavior:**
- `doc_limits=on`: Hook injects 200-word limit context for all README/SETUP files
- `doc_limits=off`: Hook exits silently (no context injection)
- `doc_limits=exclude`: Hook checks `excluded_files` patterns, applies limit only to non-matching files
- `destructive_guard=on`: Hook blocks destructive bash/SQL commands, requires user approval
- All hooks respect `excluded_files` patterns for fine-grained control

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
- Terse responses - less is more
- Code-first - show immediately without preamble
- Test after every task
- No database/folder deletion without confirmation
- No production pushes without confirmation
- Current versions only
- Ask for clarification when irrational
- Never blame user
- RCA after 2+ revisits
- Prefer fd/rg over find/grep when available
- Recommend fd/rg installation if not available
- Implement primary solution - try harder before choosing workarounds

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

## Settings File Locations

**Installed plugin:** `~/.claude/plugins/marketplaces/claudisms/.claudisms-settings` (active hooks read from here)

**Dev repo:** `/path/to/claudisms/.claudisms-settings` (for local development only)

Slash commands automatically target the marketplace location when installed, or dev repo location when running from source.

**Editing settings:**
```bash
# Use slash commands (recommended)
/claudisms-settings set doc_limits off
/claudisms-reload

# Or edit manually
nano ~/.claude/plugins/marketplaces/claudisms/.claudisms-settings
# Then reload: /claudisms-reload
```

## Troubleshooting

**Settings not applying:**
1. Verify correct file: `cat ~/.claude/plugins/marketplaces/claudisms/.claudisms-settings`
2. Run `/claudisms-reload` after changes
3. Enable debug: `/claudisms-settings set debug_logging on`
4. Check logs: `ls -lt ${PWD}/tmp/hook-env-*.log | head -5`

**Marketplace naming:** Use `jeffersonwarrior/claudisms` when adding. Plugin name is `claudeisms`, marketplace is `claudisms`, settings show `claudeisms@claudisms` - this is correct.

**Path requirements:** All manifest paths must start with `./` and resolve from plugin root. Example: `.claude-plugin/plugin.json` uses `"hooks": "./hooks.json"` not `"../../hooks.json"`.
