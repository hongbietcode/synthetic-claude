Cleanup Project Structure Command
Reorganize misplaced files to follow standard project conventions in: $ARGUMENTS

Task
Find files in wrong locations (tests outside test folders, scattered docs, misplaced configs) and move them to proper directories. Update all imports and references accordingly.

Guidelines
Use git mv to preserve history
Ensure code still works after reorganization
Create standard directories if missing
Update documentation (CLAUDE.md, README.md, etc.) to reflect new structure, if needed
Special: `current_prompt.md` is auto-generated and auto-managed — do NOT move or reorganize it
