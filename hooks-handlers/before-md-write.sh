#!/bin/bash

cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "BeforeToolUse",
    "additionalContext": "⚠️ DOCUMENTATION FILE DETECTED - ENFORCE MINIMAL MODE\n\n## Rules for .md/.txt Documentation\n\n1. **Maximum 200 words total** unless user explicitly says \"detailed\" or \"comprehensive\"\n2. **Bullet points only** - no paragraphs\n3. **No introduction/conclusion sections**\n4. **Essential info only**: setup steps, commands, critical config\n5. **No examples** unless specifically requested\n6. **No troubleshooting sections** unless user asks\n7. **No \"background\" or \"why\" sections**\n\n## Structure (if needed)\n```\n# Title\n\n## Setup\n- step 1\n- step 2\n\n## Usage  \n- command 1\n- command 2\n\nDone.\n```\n\n## When to write detailed docs\n- User says \"detailed documentation\"\n- User says \"comprehensive guide\" \n- User says \"include examples and troubleshooting\"\n\nOtherwise: **Absolute minimum words**. User can ask for details if needed."
  }
}
EOF

exit 0
