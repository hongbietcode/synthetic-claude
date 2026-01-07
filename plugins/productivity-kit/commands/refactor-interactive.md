# Interactive Refactor Command

Refactor $ARGUMENTS through small, reviewable steps with explanations.

## Process

### 1. Analysis Phase
Analyze the file and list refactoring opportunities ordered by safety and value. Start with quick wins.

### 2. Interactive Loop
For each refactoring:
- **Propose**: Explain what to change, why, and which pattern/principle applies
- **Show**: Provide before/after code example (meaningful chunks - not too large to review, not too small to be trivial)
- **Wait**: Get confirmation before proceeding
- **Apply**: Make only that specific change
- **Explain**: What was done and what principle was demonstrated

### 3. Focus Areas
Consider improvements in:
- Code organization and clarity
- Design patterns (Strategy, Factory, Observer, etc.)
- SOLID principles
- Performance optimizations
- Removing duplication

## Guidelines
- One change at a time
- Keep each refactoring meaningful - complete enough to demonstrate a principle, small enough to review easily
- Preserve functionality unless explicitly discussed
- Each step should be independently reviewable
- Connect changes to broader principles for learning
- Build each refactoring on previous improvements

## Goal
Create a collaborative refactoring session where the user learns patterns while improving their code incrementally.