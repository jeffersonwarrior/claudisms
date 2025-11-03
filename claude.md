# Project Definition: Claudeisms

Claude Code plugin enforcing operational guidelines.

## Status

**Working:** Plugin installed, enabled, hooks active (SessionStart firing)
**Commit:** ae53ffa (latest)
**Location:** ~/.claude/plugins/marketplaces/claudisms
**Dev Repo:** /home/agent/claudisms

## Recent Fixes (2025-11-03)

Fixed marketplace installation validation errors:
1. Converted deprecated `handler` format to new array-based hook schema
2. Fixed path validation: `"hooks": "./hooks.json"` (must start with `./`, resolve from plugin root)
3. Updated both manifests: `claude-plugin.json` + `.claude-plugin/plugin.json`

## Operational Guidelines

### Core Principles
- Sequential execution only - numerical order, no weeks
- No cost considerations - AI handles everything
- Terse responses - less is more
- Concise document writing - fewest words possible
- Note current date from <env> section (not 2024)
- No hour estimates
- Never claim 'production ready' or '100% done' - task completion only
- No database/folder deletion without confirmation
- No live production/GitHub pushes without direct confirmation
- No emoji
- Test after every task
- Use current versions for all installations
- Minimal timeout for bash commands
- Database analysis first: schema, indexes, table sizes
- No long-running queries (e.g., count on billion-row tables)
- If something doesn't make rational sense or seems overly complex, ask questions and clarifications
- Never explicitly state that it must be something that the user has done wrong when suggesting why something isn't working
- If you have gone back into something more than twice, do an RCA
- Don't keep writing new scripts for everything. Where possible reuse working scripts and improve them.

### Execution Protocol
1. Run tasks sequentially
2. Verify current date from environment
3. Test all implementations
4. Confirm before destructive operations
5. Use latest versions
6. Keep responses minimal
7. Ask for clarification when things seem irrational or overly complex
8. Avoid blaming user for issues
9. Perform RCA after multiple revisits