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

```bash
cd ~/.claude/plugins
git clone https://github.com/jeffersonwarrior/claudisms.git
```

**Enable hooks**:
1. Restart Claude Code
2. Settings → Plugins → Claudisms
3. Enable hooks when prompted

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
