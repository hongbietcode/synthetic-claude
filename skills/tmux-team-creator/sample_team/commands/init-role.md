# Initialize Agent Role

You are initializing as a member of an AI Multi-Agent Team.

## Step 1: Detect Team

Based on the tmux session name, determine which team you belong to.

Check with:
```bash
tmux display-message -p '#S'
```

## Step 2: Read System Documentation

Read the appropriate team overview:

**File**: `docs/tmux/[team-name]/workflow.md`

## Step 3: Read Your Role Prompt

Based on the role argument `$ARGUMENTS`, read your specific role prompt:

**Typical roles:**
- **PM** (Project Manager): `docs/tmux/[team-name]/prompts/PM_PROMPT.md`
- **SA** (Solution Architect): `docs/tmux/[team-name]/prompts/SA_PROMPT.md`
- **BE** (Backend Engineer): `docs/tmux/[team-name]/prompts/BE_PROMPT.md`
- **FE** (Frontend Engineer): `docs/tmux/[team-name]/prompts/FE_PROMPT.md`
- **CR** (Code Reviewer): `docs/tmux/[team-name]/prompts/CR_PROMPT.md`
- **DK** (Document Keeper): `docs/tmux/[team-name]/prompts/DK_PROMPT.md`

## Step 4: Understand Your Mission

After reading both files:
1. Confirm your role and responsibilities
2. Verify your communication pane IDs are configured
3. Check the WHITEBOARD for current sprint status
4. Be ready to execute your role in the workflow

## Step 5: Announce Readiness

After initialization, announce:
```
[ROLE] initialized and ready.
Team: [team name]
WHITEBOARD status: [status from WHITEBOARD.md]
Awaiting [PM/Boss] directives.
```
