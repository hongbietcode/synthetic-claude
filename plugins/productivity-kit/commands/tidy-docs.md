# Tidy Docs Command

Reorganize documentation in $ARGUMENTS to clearly distinguish permanent project docs from temporary ones.

## Task
Separate essential long-term documentation from temporary files (reviews, refactors, reports ...) using clear directory structure that instantly communicates importance to any developer.

## Guidelines
- Core docs stay accessible at top level or in `core/`, `essential/`, or similar
- Temporary docs move to clearly-marked directories like `_temp/`, `archive/`, or dated folders
- Directory names should be self-explanatory about content importance
- Update all references in CLAUDE.md and other docs
- **Special**: `current_prompt.md` is auto-generated and auto-managed — do NOT move or reorganize it