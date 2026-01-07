# Python to Notebook Command

Create Jupyter notebook from feature specification: $ARGUMENTS

## Process
1. Read the feature description from the markdown file
2. Implement the feature in a `.py` file with clean, modular code
3. Write comprehensive tests to verify functionality
4. Once tests pass, convert the Python code to `.ipynb` format with markdown cells explaining each section
5. Archive original files to `./backup/py2notebook/` with timestamp

## Output
- Feature notebook with explanatory markdown cells
- Archived Python and test files
- Summary of what was implemented