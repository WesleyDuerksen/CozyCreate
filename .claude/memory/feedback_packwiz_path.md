---
name: packwiz full path required
description: packwiz is installed at ~/go/bin/packwiz and must be invoked with its full path
type: feedback
---

# packwiz Full Path Required

Always call packwiz using its full path: `~/go/bin/packwiz` (or equivalently `/home/kavikick/go/bin/packwiz`).

The bare `packwiz` command is not on the default PATH and will fail with "command not found".

## Rule

Every packwiz invocation in bash commands must use the full path:

```bash
~/go/bin/packwiz <subcommand>
```

Never: `packwiz <subcommand>`
