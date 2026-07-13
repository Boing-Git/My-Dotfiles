#!/usr/bin/env python3
import argparse
import os
import re
import sys

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
VARIABLES_PATH = os.path.join(SCRIPT_DIR, '..', 'Variables', 'variables.js')

def load_variables():
    try:
        with open(VARIABLES_PATH, 'r') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Error: Could not find variables.js at {VARIABLES_PATH}")
        sys.exit(1)

def save_variables(content):
    with open(VARIABLES_PATH, 'w') as f:
        f.write(content)

def parse_all(content):
    matches = re.finditer(r'^var\s+([a-zA-Z0-9_]+)\s*=\s*(.*?);?$', content, re.MULTILINE)
    variables = {}
    for match in matches:
        variables[match.group(1)] = match.group(2).strip()
    return variables

def cmd_list():
    content = load_variables()
    variables = parse_all(content)
    for k, v in variables.items():
        print(f"{k}: {v}")

def cmd_get(key):
    content = load_variables()
    variables = parse_all(content)
    if key in variables:
        print(variables[key])
    else:
        print(f"Error: Variable '{key}' not found.")
        sys.exit(1)

def cmd_set(key, value):
    content = load_variables()
    variables = parse_all(content)
    
    if key not in variables:
        print(f"Error: Variable '{key}' not found.")
        sys.exit(1)
        
    old_value = variables[key]
    
    # Infer type from old_value to format new value correctly
    new_value_str = value
    if old_value.startswith('"') and old_value.endswith('"'):
        # Ensure new value has quotes
        if not (new_value_str.startswith('"') and new_value_str.endswith('"')):
            new_value_str = f'"{new_value_str}"'
    elif old_value.startswith("'") and old_value.endswith("'"):
        # Ensure new value has quotes
        if not (new_value_str.startswith("'") and new_value_str.endswith("'")):
            new_value_str = f"'{new_value_str}'"
    elif old_value in ("true", "false", "true;", "false;"):
        new_value_str = new_value_str.lower()
        if new_value_str not in ("true", "false"):
            print("Error: Expected 'true' or 'false' for boolean variable.")
            sys.exit(1)
    # else, it's a number, array, or object, we trust the user input
    
    # Replace in file using regex
    pattern = rf'^(var\s+{key}\s*=\s*)(.*?)(;?)$'
    
    def repl(m):
        # m.group(1) is 'var key = '
        # m.group(2) is old value
        # m.group(3) is ';' or ''
        return f"{m.group(1)}{new_value_str}{m.group(3)}"
        
    new_content, count = re.subn(pattern, repl, content, count=1, flags=re.MULTILINE)
    
    if count == 0:
        print(f"Error: Failed to replace variable '{key}'.")
        sys.exit(1)
        
    save_variables(new_content)
    print(f"Set '{key}' to {new_value_str}")

def main():
    parser = argparse.ArgumentParser(description="Quickshell Settings CLI")
    subparsers = parser.add_subparsers(dest="command", required=True)
    
    # get
    parser_get = subparsers.add_parser("get", help="Get a variable value")
    parser_get.add_argument("key", help="The variable name")
    
    # set
    parser_set = subparsers.add_parser("set", help="Set a variable value")
    parser_set.add_argument("key", help="The variable name")
    parser_set.add_argument("value", help="The new value")
    
    # list
    parser_list = subparsers.add_parser("list", help="List all variables")
    
    args = parser.parse_args()
    
    if args.command == "get":
        cmd_get(args.key)
    elif args.command == "set":
        cmd_set(args.key, args.value)
    elif args.command == "list":
        cmd_list()

if __name__ == "__main__":
    main()
