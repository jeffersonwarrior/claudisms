# Claudeisms

Operational guidelines skill for Claude Code that establishes strict protocols for AI task execution.

## What It Does

Claudeisms enforces consistent, efficient AI behavior through:

- Sequential task execution (no "weeks", just numerical order)
- Terse, minimal responses
- No destructive operations without confirmation
- Mandatory testing after all tasks
- Script reuse over writing new ones
- Rational complexity checks with user clarification
- Root cause analysis after multiple revisits

## Installation

### Option 1: Clone Repository
```bash
git clone https://github.com/jeffersonwarrior/claudisms.git
cd claudeisms
```

### Option 2: Add to Existing Project
```bash
mkdir -p .claude/skills/claudeisms
curl -o .claude/skills/claudeisms/SKILL.md https://raw.githubusercontent.com/jeffersonwarrior/claudisms/main/.claude/skills/claudeisms/SKILL.md
```

### Option 3: Direct Claude Command
Tell Claude:
> "Use the Claudeisms skill from https://github.com/jeffersonwarrior/claudisms"

Note: Claude cannot directly install skills from URLs. Use Option 1 or 2 first.

## Usage

Once installed, restart Claude Code. The skill automatically activates when relevant to tasks.

To explicitly invoke:
> "Apply Claudeisms guidelines to this task"

## Core Principles

- Sequential execution only
- No cost considerations
- Terse responses
- No production claims
- No emoji
- Test everything
- Reuse scripts
- Ask for clarification when irrational
- Never blame user
- RCA after multiple revisits

## License

GPL v3