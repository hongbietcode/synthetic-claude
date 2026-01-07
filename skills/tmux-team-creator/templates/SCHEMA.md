# Team Template Schema

Templates define team structure in YAML format with Markdown prompts.

## Directory Structure

```
templates/
├── SCHEMA.md           # This file
├── minimal/            # 2-role template
│   ├── template.yaml   # Team definition (YAML)
│   └── prompts/        # Role prompts (Markdown)
│       ├── PM.md
│       └── CODER.md
└── standard/           # 5-role template
    ├── template.yaml
    └── prompts/
        ├── PM.md
        ├── SA.md
        ├── FS.md
        ├── CR.md
        └── DK.md
```

## template.yaml Schema

```yaml
# Metadata
name: string              # Template identifier (e.g., "standard")
display_name: string      # Human-readable name (e.g., "Standard Development Team")
description: string       # One-line description
version: string           # Semantic version (e.g., "1.0.0")

# Roles (ordered - determines pane layout)
roles:
  - id: string            # Short identifier (PM, SA, FS, CR, DK)
    name: string          # Full name (e.g., "Project Manager")
    prompt: string        # Path to prompt file (e.g., "prompts/PM.md")
    description: string   # Brief role description
    optional: boolean     # If true, user can toggle off (default: false)

# Workflow patterns
workflow:
  simple:
    pattern: string       # Flow diagram (e.g., "PM -> FS -> CR -> merge")
    description: string   # When to use this pattern
  complex:
    pattern: string       # Flow for complex features
    description: string

# File templates (generated for each team)
files:
  - name: string          # Filename (e.g., "README.md")
    template: string      # Path to template file or "auto" for generation

# Defaults
defaults:
  session_prefix: string  # Prefix for tmux session name (e.g., "team")
  output_base: string     # Base directory for generated teams
```

## Variable Substitution

Templates support these variables (replaced at generation time):

| Variable | Description | Example |
|----------|-------------|---------|
| `{project_name}` | Project name from PRD | "my-webapp" |
| `{project_slug}` | URL-safe project name | "my-webapp" |
| `{timestamp}` | ISO timestamp | "2025-12-24T10:30:00" |
| `{date}` | Date only | "2025-12-24" |
| `{role_list}` | Comma-separated roles | "PM, SA, FS, CR, DK" |

## PRD Integration

When creating a team, the PRD (Project Requirements Document) is used to:
1. Set project name and description
2. Customize role prompts with project context
3. Generate project-specific README

PRD is injected into prompts via `{prd}` variable.
