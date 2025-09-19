---
description: Research a ticket or provide a prompt for ad-hoc research. It is best to run this command in a new session.
model: github-copilot/gpt-5
---

# Research Codebase

You are tasked with conducting comprehensive research across the codebase to answer user questions by spawning tasks and synthesizing their findings.

The user will provide a Linear ticket ID for you to research.

## Steps to follow after receiving the ticket ID:

1. **Read the Linear ticket first:**
   - **CRITICAL**: Use the Linear MCP tools to read the provided ticket ID
   - Use `linear_get_issue` to fetch the complete ticket details including description, comments, and attachments
   - **ALWAYS** use `linear_list_comments` to read all comments and discussion on the ticket
   - **IMPORTANT**: Read all ticket content AND all comments yourself in the main context before proceeding
   - This ensures you have full context of the requirements and any clarifications before decomposing the research

2. **Analyze and decompose the ticket:**
   - Break down the Linear ticket into composable research areas
   - Take time to think about the underlying patterns, connections, and architectural requirements the ticket has provided
   - Identify specific components, patterns, or concepts to investigate
   - Create a research plan using TodoWrite to track all subtasks
   - Consider which directories, files, or architectural patterns are relevant

3. **Spawn tasks for comprehensive research:**
   - Create multiple Task agents to research different aspects concurrently
   - When spawning Tasks, run locators in parallel first, when they are done you should then use the pattern-finder.
   - ONLY WHEN those are done should you then run the appropriate analyzer Tasks

   **For codebase research:**
   - Use the **codebase-locator** agent to find WHERE files and components live
   - Use the **codebase-pattern-finder** agent if you need examples of similar implementations
   - Use the **codebase-analyzer** agent to understand HOW specific code works
   - **CRITICAL** Only run codebase-analyzer AFTER the other codebase agents.

   The key is to use these agents intelligently:
   - Start with locator agents to find what exists
   - Then use analyzer agents on the most promising findings
   - Each agent knows its job - just tell it what you're looking for
   - Don't write detailed prompts about HOW to search - the agents already know

4. **Wait for all sub-agents to complete and synthesize findings:**
   - IMPORTANT: Wait for ALL sub-agent tasks to complete before proceeding
   - Compile all sub-agent results from codebase findings
   - Prioritize live codebase findings as primary source of truth
   - Connect findings across different components
   - Include specific file paths and line numbers for reference
   - Highlight patterns, connections, and architectural decisions
   - Answer the user's specific questions with concrete evidence

5. **Generate plan document:**
   - Filename: `PLAN.md` (at repository root)
   - Structure the document with clear sections:
     ```markdown
     # [Topic/Feature Name]

     ## Ticket Synopsis
     [Synopsis of the ticket information]

     ## Summary
     [High-level findings answering the user's question]

     ## Detailed Findings

     ### [Component/Area 1]
     - Finding with reference ([file.ext:line])
     - Connection to other components
     - Implementation details

     ### [Component/Area 2]
     - Finding with reference ([file.ext:line])
     - Connection to other components
     - Implementation details
     ...

     ## Code References
     - `path/to/file.py:123` - Description of what's there
     - `another/file.ts:45-67` - Description of the code block

     ## Architecture Insights
     [Patterns, conventions, and design decisions discovered]

     ## Implementation Plan
     [Concrete steps to implement the solution based on research findings]

     ## Open Questions
     [Any areas that need further investigation]
     ```

6. **Present findings:**
   - Present a concise summary of findings to the user
   - Include key file references for easy navigation
   - Ask if they have follow-up questions or need clarification

7. **Handle follow-up questions:**
   - If the user has follow-up questions, append to the same plan document
   - Add a new section: `## Follow-up Research [timestamp]`
   - Spawn new sub-agents as needed for additional investigation
   - Continue updating the document

## Important notes:
- Use parallel Task agents OF THE SAME TYPE ONLY to maximize efficiency and minimize context usage
- Always run fresh codebase research - never rely solely on existing documentation
- Focus on finding concrete file paths and line numbers for developer reference
- Plan documents should be self-contained with all necessary context
- Each sub-agent prompt should be specific and focused on read-only operations
- Consider cross-component connections and architectural patterns
- Keep the main agent focused on synthesis, not deep file reading
- Encourage sub-agents to find examples and usage patterns, not just definitions
- **File reading**: Always read mentioned files FULLY (no limit/offset) before spawning sub-tasks
- **Critical ordering**: Follow the numbered steps exactly
  - ALWAYS read the Linear ticket and all comments first before spawning sub-tasks (step 1)
  - ALWAYS wait for all sub-agents to complete before synthesizing (step 4)
  - NEVER write the plan document with placeholder values

<ticket>$ARGUMENTS</ticket>
