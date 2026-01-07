- Execute prompt in file $ARGUMENTS 
- Read the prompt from the file $ARGUMENTS (if not given then execute prompt in file current_prompt.md) - if both do not exist then just ask user what to do
- Re-read the file, it may changed since last time you read it
- Guide for recall memory:
Read the part "# To execute" first and consider whether the task is not trivial enough (i.e it can just be done in 1-2 simple steps) - if it's not simple, the --recall your memory to find any information that helps you complete the task.