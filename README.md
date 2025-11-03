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

## Troubleshooting

**Marketplace naming:** Use `jeffersonwarrior/claudisms` when adding. Plugin name is `claudeisms`, marketplace is `claudisms`, settings show `claudeisms@claudisms` - this is correct.

**Path requirements:** All manifest paths must start with `./` and resolve from plugin root. Example: `.claude-plugin/plugin.json` uses `"hooks": "./hooks.json"` not `"../../hooks.json"`.
