# Claudisms 2.2 Enhancement Plan

## 1. Intelligent Documentation Writing Strategy

**Problem:** Current restrictions too broad - prevents legitimate writes to system docs.

**Solution:** Context-aware write policies with intelligence layers:

```typescript
// Write policy modes
enum WriteMode {
  SUMMARY_ONLY,    // Short summaries (<200 words) for CLAUDE.md, agents.md
  STRUCTURED,      // Structured updates to config/planning docs
  FULL_ACCESS      // Complete write access
}

// File classification
const writeRules = {
  'CLAUDE.md': {
    mode: WriteMode.SUMMARY_ONLY,
    maxLines: 50,
    requireConciseness: true,
    blockEssays: true
  },
  'agents.md': {
    mode: WriteMode.SUMMARY_ONLY,
    maxLines: 30
  },
  '*.plan.md': {
    mode: WriteMode.STRUCTURED,
    allowAppends: true,
    requireSectionHeaders: true
  },
  'settings.json': {
    mode: WriteMode.FULL_ACCESS,
    requireValidation: true
  }
}
```

**Implementation:**
- Hook intercepts Write tool calls
- Analyzes target file type and content length
- For CLAUDE.md: enforce "## Update: [date]" format with <50 line limit
- For essays: suggest creating separate project-specific docs
- Setting: `intelligent_writes` (default: true)

---

## 2. System Settings Write Access

**Problem:** Can't modify own settings.json or system config.

**Solution:** Explicit self-config permission:

```json
// settings.json additions
{
  "selfConfigAccess": {
    "enabled": true,  // default: true
    "allowedFiles": [
      "settings.json",
      "hooks.json",
      "preferences.json",
      ".claudisms/config.json"
    ],
    "requireBackup": true,  // auto-backup before changes
    "maxChangesPerSession": 10  // prevent runaway edits
  }
}
```

**Safeguards:**
- Auto-backup to `settings.json.bak` before changes
- Validation after write (JSON parsing)
- Rollback on validation failure
- Audit log in `.claudisms/changes.log`

---

## 3. Directory Traversal Controls (Optional Jailing)

**Problem:** Locked to working directory by default - can't explore system.

**Solution:** Jail-free by default, opt-in restriction:

```json
{
  "directoryJail": {
    "enabled": false,  // default: OFF
    "jailRoot": null,  // when enabled: "/home/agent" or custom
    "allowedPaths": [], // whitelist when jailed
    "blockPaths": [     // blacklist when jailed
      "/etc/shadow",
      "/root",
      "/proc"
    ]
  }
}
```

**Behavior:**
- `enabled: false` → Full filesystem access (respect user permissions)
- `enabled: true` → Restrict to `jailRoot` + `allowedPaths`
- Still respect OS-level permissions (can't read root-only files as user)
- Setting: `--jail-dir=/path` CLI flag or settings toggle

---

## 4. TUI for Settings Management (`./set-claudisms`)

**Tool:** `whiptail` (Linux/macOS compatible, no external deps)

**Features:**
```bash
#!/usr/bin/env bash
# set-claudisms - Interactive TUI for Claudisms config

whiptail --title "Claudisms Settings" --checklist \
"Configure Claudisms behavior:" 20 78 10 \
"INTELLIGENT_WRITES" "Smart doc length limits" ON \
"SELF_CONFIG" "Edit own settings.json" ON \
"DIRECTORY_JAIL" "Restrict filesystem access" OFF \
"VERBOSE_HOOKS" "Show hook execution details" OFF \
"AUTO_SUBAGENTS" "Use subagents for search tasks" ON \
"CONCISE_MODE" "Terse responses by default" ON \
"BLOCK_ESSAYS" "Prevent 500-line documentation" ON \
"BACKUP_CONFIGS" "Auto-backup before changes" ON \
3>&1 1>&2 2>&3
```

**Implementation:**
- Script: `/home/agent/claudisms/bin/set-claudisms`
- Reads: `~/.claude/plugins/marketplaces/claudisms/settings.json`
- Updates settings in-place
- Validates JSON after changes
- Shows current values as defaults
- Cross-platform: uses `whiptail` (Linux) or `dialog` (macOS)

**Install:**
```bash
cd /home/agent/claudisms
chmod +x bin/set-claudisms
ln -s $(pwd)/bin/set-claudisms /usr/local/bin/set-claudisms
```

---

## 5. Subagent Best Practices Integration

**Enhancement:** Update CLAUDE.md and hooks to encourage subagent use.

**Additions to system prompt:**
```markdown
## Subagent Usage Guidelines

**Use Task tool with subagent_type=Explore for:**
- Codebase structure questions ("how does X work?")
- Multi-file searches (>3 files)
- Ambiguous queries ("where is error handling?")
- Architecture understanding

**Subagent Description Best Practices:**
- Format: "Action + Scope + Expected Output"
- Good: "Search codebase for authentication flows and middleware usage"
- Bad: "Find auth stuff"
- Include thoroughness level: "quick", "medium", "very thorough"
- Specify output format: "Return file paths and line numbers"

**Examples:**
```typescript
// ❌ Vague
Task("Find files", "look for config files", "Explore")

// ✅ Concise + Informative
Task(
  "Locate config files",
  "Search for *.config.js|.json|.yaml in src/ and root. Return paths with modification dates. Thoroughness: medium",
  "Explore"
)
```

**Hook Integration:**
- Pre-search hook suggests subagent for >2 Grep calls
- Post-search hook asks "Should this be a subagent?" if 5+ files touched
- Setting: `prefer_subagents` (default: true)

---

## Implementation Priority

1. TUI settings tool (`set-claudisms`)
2. Self-config access + backups
3. Directory jail toggle (default OFF)
4. Intelligent write policies
5. Subagent prompt enhancements

---

## Testing Checklist

- [ ] TUI runs on Linux (Ubuntu/Debian)
- [ ] TUI runs on macOS (with dialog fallback)
- [ ] Settings persist after restart
- [ ] JSON validation catches malformed edits
- [ ] Backups created before config changes
- [ ] Directory jail blocks traversal when enabled
- [ ] Directory jail allows full access when disabled
- [ ] CLAUDE.md writes limited to <50 lines
- [ ] Essay detection triggers separate file suggestion
- [ ] Subagent descriptions include thoroughness level

---

## Time Estimation Guidelines

**For AI agents:** Estimate in operations/complexity, not human time units.
- Simple: Single file edit, config change
- Moderate: Multi-file refactor, new feature with tests
- Complex: Architecture change, cross-system integration

**For humans:** Omit time estimates entirely or use operational checkpoints.

---

## Backward Compatibility

- All new features OFF or permissive by default
- Existing settings.json still valid (new fields optional)
- Old behavior: add `"legacy_mode": true` to preserve v2.1 behavior
- Migration script: `./bin/migrate-settings-v2.2`
