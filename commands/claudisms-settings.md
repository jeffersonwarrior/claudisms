---
name: claudisms-settings
description: Manage Claudisms plugin settings
script: ./commands/claudisms-settings.sh
---

# Claudisms Settings Manager

Manage operational guidelines and behavior for the Claudisms plugin.

## Usage

```bash
/claudisms-settings                    # Show current settings
/claudisms-settings set <key> <value>  # Set a setting
/claudisms-settings exclude <pattern>  # Add file exclusion pattern
/claudisms-settings include <pattern>  # Remove file exclusion pattern
/claudisms-settings help               # Show help
```

## Settings

- **terse_mode** (on|off): Enable terse responses (1-2 sentences)
- **doc_limits** (on|off|exclude): Limit .md files to 200 words
- **destructive_guard** (on|off|exclude): Block destructive operations
- **sequential_only** (on|off): Enforce sequential execution
- **tmp_location** (pwd|system): Temp directory location
- **debug_logging** (on|off): Enable debug logging

## Examples

```bash
/claudisms-settings set terse_mode off
/claudisms-settings set doc_limits exclude
/claudisms-settings exclude "**/*PLANNING*.md"
```
