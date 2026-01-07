"""
Simple LangChain Agent with Tools - Educational Version

This is a minimal, clean implementation of an agent that can use tools.
Stripped of all logging, caching, and UI complexity for clarity.
This seems simple, but this same agent-loop is being used in one of the most powerful agents in the world: claude-code - the coding agent.
So, always use this to build agent, forget all the bullshit ReAct/Reflection agents .... blahblah

The main agent is just a loop.
The session memory is just a list of messages.
It is enough to build the most powerful agent in the world. PERIOD !s
"""

from typing import List, Dict, Any, Optional
from langchain_core.messages import SystemMessage, HumanMessage, ToolMessage
from langchain_core.tools import BaseTool
from langchain.chat_models import init_chat_model
from dotenv import load_dotenv
load_dotenv()


DEFAULT_MODEL_NAME = "grok-code-fast-1"

# =============================================================================
# Supported Model Examples (init_chat_model auto-detects provider from name):
# =============================================================================
# "gpt-4.1"                          -> OpenAI (needs OPENAI_API_KEY)
# "claude-sonnet-4-5-20250929"       -> Anthropic (needs ANTHROPIC_API_KEY)
# "google_genai:gemini-2.5-flash"    -> Google (needs GOOGLE_API_KEY)
# "grok-code-fast-1"                 -> xAI (needs XAI_API_KEY)
#
# Or explicitly specify provider:
#   init_chat_model("my-model", model_provider="openai")
# =============================================================================
class SimpleAgent:
    """
    A minimal agent that uses tools to accomplish tasks.

    The core loop is:
    1. User sends a message
    2. LLM responds (possibly with tool calls)
    3. If tool calls exist, execute them and feed results back
    4. Repeat until LLM responds without tool calls
    """

    def __init__(
        self,
        system_prompt: str,
        tools: List[BaseTool],
        model_name: str = DEFAULT_MODEL_NAME,
        model_provider: Optional[str] = None,
    ):
        """
        Initialize the agent.

        Args:
            system_prompt: Instructions that define agent behavior
            tools: List of LangChain tools the agent can use
            model_name: The LLM model to use (e.g., "gpt-4.1", "claude-sonnet-4-5-20250929")
            model_provider: Optional provider override (e.g., "openai", "anthropic", "xai")
        """
        # Store the tools in a map for quick lookup by name
        self.tools_map: Dict[str, BaseTool] = {tool.name: tool for tool in tools}

        # Create the LLM using the universal init_chat_model
        # This auto-detects the provider from the model name, or uses explicit provider
        llm = init_chat_model(model_name, model_provider=model_provider)
        self.llm_with_tools = llm.bind_tools(tools)

        # Initialize conversation with system prompt
        self.messages: List[Any] = [SystemMessage(content=system_prompt)]

    def chat(self, user_input: str) -> str:
        """
        Process a user message and return the agent's response.

        This implements the ReAct (Reasoning + Acting) loop:
        - LLM thinks about what to do
        - LLM calls tools if needed
        - Results are fed back until task is complete
        """
        # Add user message to conversation history
        self.messages.append(HumanMessage(content=user_input))

        # Get LLM response
        response = self.llm_with_tools.invoke(self.messages)
        self.messages.append(response)

        # Tool execution loop - keep going while LLM wants to use tools
        while hasattr(response, "tool_calls") and response.tool_calls:

            # Execute each tool call
            for tool_call in response.tool_calls:
                tool_name = tool_call["name"]
                tool_args = tool_call["args"]
                tool_id = tool_call["id"]

                print(f"🔧 Calling tool: {tool_name}")
                print(f"   Args: {tool_args}")

                # Execute the tool
                if tool_name in self.tools_map:
                    result = self.tools_map[tool_name].invoke(tool_args)
                else:
                    result = f"Error: Unknown tool '{tool_name}'"

                print(f"   Result: {str(result)[:200]}...")

                # Add tool result to conversation
                # The tool_call_id links the result to the specific call
                self.messages.append(
                    ToolMessage(content=str(result), tool_call_id=tool_id)
                )

            # Get next LLM response (it will see the tool results)
            response = self.llm_with_tools.invoke(self.messages)
            self.messages.append(response)

        # Return the final text response
        return response.content

    def reset(self):
        """Clear conversation history, keeping only the system prompt."""
        self.messages = [self.messages[0]]


# =============================================================================
# Example Usage
# =============================================================================

if __name__ == "__main__":
    from langchain_core.tools import tool

    # Define tools with DETAILED docstrings - this is CRITICAL for LLM performance!
    # The docstring IS the prompt that tells the LLM how to use the tool.
    # Poor docstrings = poor tool usage = broken agent.

    @tool("Read")
    def read_file(file_path: str) -> str:
        """Reads a file from the local filesystem and returns its contents.

        ## Usage Guidelines
        - **file_path must be ABSOLUTE** (e.g., /Users/name/project/file.py), NOT relative
        - Returns file contents with line numbers in `cat -n` format
        - If file doesn't exist, returns an error message (this is OK, don't panic)

        ## When to Use
        - Reading source code to understand implementation
        - Checking configuration files
        - Examining logs or output files
        - ALWAYS read a file BEFORE trying to edit or write to it

        ## Performance Tips
        - You can call this tool multiple times in parallel for different files
        - Read files speculatively if you think they might be useful

        Args:
            file_path: The ABSOLUTE path to the file to read (e.g., /Users/name/project/src/main.py)

        Returns:
            File contents with line numbers, or error message if file not found
        """
        try:
            with open(file_path, 'r') as f:
                lines = f.readlines()
            # Format with line numbers like cat -n
            result = []
            for i, line in enumerate(lines, 1):
                result.append(f"{i:6d}\t{line.rstrip()}")
            return "\n".join(result)
        except FileNotFoundError:
            return f"Error: File not found: {file_path}"
        except Exception as e:
            return f"Error reading file: {e}"

    @tool("Write")
    def write_file(file_path: str, content: str) -> str:
        """Writes content to a file, creating it if it doesn't exist or OVERWRITING if it does.

        ## Usage Guidelines
        - **file_path must be ABSOLUTE** (e.g., /Users/name/project/file.py), NOT relative
        - This will OVERWRITE the entire file - use Edit tool for partial modifications
        - Creates parent directories automatically if they don't exist
        - **CRITICAL**: ALWAYS use Read tool first to check existing content before writing!

        ## When to Use
        - Creating NEW files that don't exist yet
        - Completely replacing file contents (use Edit for partial changes)
        - Writing generated code, configs, or documentation

        ## When NOT to Use
        - Modifying existing files (use Edit tool instead)
        - If you haven't read the file first (you might lose important content!)

        Args:
            file_path: The ABSOLUTE path to write to (e.g., /Users/name/project/src/new_file.py)
            content: The complete content to write to the file

        Returns:
            Success message with file path, or error message
        """
        import os
        try:
            # Create directory if needed
            dir_path = os.path.dirname(file_path)
            if dir_path:
                os.makedirs(dir_path, exist_ok=True)

            with open(file_path, 'w') as f:
                f.write(content)
            return f"Successfully wrote {len(content)} characters to {file_path}"
        except Exception as e:
            return f"Error writing file: {e}"

    @tool("Bash")
    def run_command(command: str, working_dir: str = None) -> str:
        """Executes a bash/shell command and returns the output (stdout + stderr).

        ## Usage Guidelines
        - Use for running scripts, builds, tests, git commands, etc.
        - Commands timeout after 30 seconds
        - Use absolute paths in commands to avoid directory confusion
        - Chain commands with && or ; (e.g., "cd /path && npm install")

        ## When to Use
        - Running build tools (npm, pip, cargo, make, etc.)
        - Git operations (git status, git diff, git commit, etc.)
        - Running tests (pytest, jest, cargo test, etc.)
        - System commands (ls, pwd, which, etc.)

        ## When NOT to Use
        - Reading files (use Read tool instead of cat/head/tail)
        - Searching files (use dedicated search tools instead of grep/find)
        - File operations that have dedicated tools

        ## Security Note
        - Avoid running untrusted commands
        - Be careful with rm, chmod, and other destructive commands

        Args:
            command: The shell command to execute (e.g., "git status", "npm install", "python script.py")
            working_dir: Optional working directory for the command (absolute path)

        Returns:
            Command output (stdout + stderr combined), or error/timeout message
        """
        import subprocess
        import os
        try:
            cwd = working_dir if working_dir else os.getcwd()
            result = subprocess.run(
                command,
                shell=True,
                capture_output=True,
                text=True,
                timeout=30,
                cwd=cwd
            )
            output = result.stdout
            if result.stderr:
                output += f"\nSTDERR:\n{result.stderr}"
            if result.returncode != 0:
                output += f"\n[Exit code: {result.returncode}]"
            return output if output.strip() else "(Command completed with no output)"
        except subprocess.TimeoutExpired:
            return "Error: Command timed out after 30 seconds"
        except Exception as e:
            return f"Error executing command: {e}"

    # Create the agent - works with any provider!
    # Examples:
    #   model_name="gpt-4.1"                     # OpenAI
    #   model_name="claude-sonnet-4-5-20250929"  # Anthropic
    #   model_name="grok-code-fast-1"            # xAI (default)
    #   model_name="gemini-2.5-flash", model_provider="google_genai"  # Google
    agent = SimpleAgent(
        system_prompt="""You are a helpful coding assistant.
You can read files, write files, and run commands.
Always explain what you're doing before taking action.""",
        tools=[read_file, write_file, run_command],
        model_name="grok-code-fast-1",  # Change this to use different providers
    )

    # Interactive loop
    print("Simple Agent Ready! Type 'quit' to exit.")
    while True:
        user_input = input("\n> ")
        if user_input.lower() in ['quit', 'exit']:
            break
        response = agent.chat(user_input)
        print(f"\n🤖 {response}")
