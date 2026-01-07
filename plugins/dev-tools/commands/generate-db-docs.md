# Generate Database Documentation Command

Create comprehensive documentation for MySQL database: $ARGUMENTS

## Task
Generate two documentation files for the database (credentials in root .env file):
1. `{db_name}_detailed_desc.md` - Technical guide with schema, sample data, query patterns
2. `{db_name}_overview.md` - Concise summary for quick reference

## Requirements
- Connect to the actual database and query real data
- Test all SQL examples before including them
- Mark tables by importance (⭐ CORE, 📊 LOG, 🔧 UTILITY)
- Include actual record counts and recent sample data
- Provide practical query patterns developers will use
- No placeholder data - everything must be verified against the database

## Output
Two markdown files with verified schema information, tested queries, and developer-focused guidance.