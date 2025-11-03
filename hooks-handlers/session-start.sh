#!/bin/bash

# Load settings
source "${CLAUDE_PLUGIN_ROOT}/lib/settings-loader.sh"

# Get tmp location for debugging logs
TMP_DIR=$(get_tmp_location)

# Debug logging if enabled
if [[ "$(get_setting 'debug_logging')" == "on" ]]; then
  echo "Session started at $(date)" > "${TMP_DIR}/session-start-$$.log"
  echo "Settings loaded from: ${CLAUDE_PLUGIN_ROOT}/.claudisms-settings" >> "${TMP_DIR}/session-start-$$.log"
fi

# Check if terse_mode is disabled
if [[ "$(get_setting 'terse_mode')" == "off" ]]; then
  # Silent exit - no context injection for normal verbosity
  exit 0
fi

# Check if sequential_only is disabled
if [[ "$(get_setting 'sequential_only')" == "off" ]]; then
  # Output context without sequential requirement
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "CLAUDEISMS PLUGIN ACTIVE\n\n## Core Principles\n- Terse responses - 1-2 sentences max\n- Code-first - show immediately\n- No emoji, no pleasantries\n- Test after every task\n- No destructive ops without confirmation\n- No production pushes without confirmation\n- Current versions only\n- RCA after 2+ revisits\n- Reuse scripts, don't recreate\n\n## Response Format\n- Single sentence for simple tasks\n- Code without preamble\n- path:line for references\n- Error: problem + fix in <10 words\n\n## Elaborate Only When\n- User asks \"why\" or \"how\"\n- User says \"explain\" or \"details\"\n- Architecture decisions need input\n- Security/data loss warnings\n\n## Never\n- Repeat user's words\n- Confirm understanding\n- Blame user for issues\n- Say 'production ready' or '100% done'\n- Long-running queries on large tables\n- Delete DB/folders without confirmation"
  }
}
EOF
else
  # Output full context including sequential requirement
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "CLAUDEISMS PLUGIN ACTIVE\n\n## Core Principles\n- Sequential execution only - no weeks, numerical order\n- Terse responses - 1-2 sentences max\n- Code-first - show immediately\n- No emoji, no pleasantries\n- Test after every task\n- No destructive ops without confirmation\n- No production pushes without confirmation\n- Current versions only\n- RCA after 2+ revisits\n- Reuse scripts, don't recreate\n\n## Response Format\n- Single sentence for simple tasks\n- Code without preamble\n- path:line for references\n- Error: problem + fix in <10 words\n\n## Elaborate Only When\n- User asks \"why\" or \"how\"\n- User says \"explain\" or \"details\"\n- Architecture decisions need input\n- Security/data loss warnings\n\n## Never\n- Repeat user's words\n- Confirm understanding\n- Blame user for issues\n- Say 'production ready' or '100% done'\n- Long-running queries on large tables\n- Delete DB/folders without confirmation"
  }
}
EOF
fi

exit 0
