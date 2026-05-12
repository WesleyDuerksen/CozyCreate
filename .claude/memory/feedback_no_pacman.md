---
name: No pacman commands
description: User does not want me to run pacman commands (search, install, query) on this Arch system
type: feedback
originSessionId: d706a651-456d-472b-9af5-e2fb52005b4e
---
Do not run `pacman -Ss`, `pacman -S`, `pacman -Q`, or any other pacman invocations.

**Why:** User explicitly rejected a `pacman -Ss eclipse-mat` lookup with "no pacman commands". They handle package management themselves.

**How to apply:** When checking for available tools, use `which`, `command -v`, or check `/usr/bin/`, `/usr/lib/`, `~/.local/bin/` directly. If a tool isn't present, suggest an alternative approach (Python, JDK-built-in, hosted service) rather than offering to install via pacman. If installation is genuinely needed, ask the user to install it themselves and tell them the package name.
