---
description: Configure Git user for current repository (personal or work)
argument-hint: personal|work
allowed-tools: [Bash]
---

# Git Configuration Command

Current directory: !`pwd`
Current Git user: !`git config user.name 2>/dev/null || echo "Not set"`
Current Git email: !`git config user.email 2>/dev/null || echo "Not set"`

**If argument is "personal":**
- Set `git config user.name "hungson175"`
- Set `git config user.email "sphamhung@gmail.com"`

**If argument is "work":**
- Set `git config user.name "son.pham9"`
- Set `git config user.email "son.pham9@mservice.com.vn"`
