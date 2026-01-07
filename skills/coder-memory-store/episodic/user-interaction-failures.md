# User Interaction Failures - Episodic Memories

This file stores concrete failure stories about user interactions and expectations.

---

## Claude Asked Too Many Questions Instead of Taking Autonomous Action

**Title:** Claude Asked Too Many Questions Instead of Taking Autonomous Action

**Description:** User expressed strong frustration when Claude kept asking about setup instead of solving problems independently.

**Content:** Task: Start MCP server v3.2. Network issues prevented Docker pull of Qdrant. Claude repeatedly asked user about setup options instead of autonomously solving: (1) switching to local file-based Qdrant, (2) patching MCP SDK compatibility bug, (3) copying API key from known location. After user's profanity ("do it your fucking self" - strong signal), Claude immediately solved all issues independently and successfully completed setup. Key lesson: When you have technical capability to solve a problem, DO IT instead of asking. User frustration/profanity signals you're being too passive. Autonomous problem-solving is expected, especially for technical setup tasks. Files modified: qdrant_memory_mcp_server_v2.py (added local Qdrant fallback), MCP SDK session.py (patched type annotation bug), created .env file.

**Tags:** #failure #strong-signal #episodic #user-expectations #autonomy #mcp-setup

**Metadata:**
- Date: 2025-12-28
- Context: MCP server v3.2 setup
- Outcome: Successfully completed after autonomous action
- Confidence: high
- Frequency: 1

---
