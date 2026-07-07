#!/usr/bin/env python3
import argparse
import re
import os
import sys

VARS_FILE = os.path.expanduser("~/.config/hypr/modules/variables.lua")

def read_file():
    if not os.path.exists(VARS_FILE):
        print(f"Error: {VARS_FILE} not found.")
        sys.exit(1)
    with open(VARS_FILE, "r") as f:
        return f.read()

def write_file(content):
    with open(VARS_FILE, "w") as f:
        f.write(content)

def parse_variables(content):
    """
    Parses the variables.lua file and returns a dictionary of variables
    with their type and comment (to be used as help text).
    """
    variables = {}
    # Matches lines like:  Key = "Value", -- Comment
    # Or:  Key = true, -- Comment
    # Or:  Key = 10,
    pattern = re.compile(r'^[ \t]*([a-zA-Z0-9_]+)[ \t]*=[ \t]*(?:"([^"]*)"|(true|false)|(\d+))(?:,?[ \t]*(--.*)?)?$', re.MULTILINE)
    
    for match in pattern.finditer(content):
        key = match.group(1)
        str_val = match.group(2)
        bool_val = match.group(3)
        num_val = match.group(4)
        comment = match.group(5)
        
        help_text = comment.strip("- ") if comment else f"Set {key}"
        
        if str_val is not None:
            val_type = "string"
        elif bool_val is not None:
            val_type = "bool"
        elif num_val is not None:
            val_type = "int"
        else:
            continue
            
        variables[key] = {
            "type": val_type,
            "help": help_text
        }
        
    return variables

def update_var(content, key, value, val_type):
    """
    Update a variable in the lua file.
    val_type can be 'string', 'bool', or 'int'
    """
    if val_type == "string":
        pattern = r'([ \t]*)(' + re.escape(key) + r')([ \t]*=[ \t]*)"[^"]*"(,?[ \t]*(--.*)?)'
        replacement = rf'\1\2\3"{value}"\4'
    elif val_type == "bool":
        val_str = "true" if str(value).lower() in ["true", "1", "yes", "y", "t"] else "false"
        pattern = r'([ \t]*)(' + re.escape(key) + r')([ \t]*=[ \t]*)(true|false)(,?[ \t]*(--.*)?)'
        replacement = rf'\1\2\3{val_str}\5'
    elif val_type == "int":
        pattern = r'([ \t]*)(' + re.escape(key) + r')([ \t]*=[ \t]*)\d+(,?[ \t]*(--.*)?)'
        replacement = rf'\1\2\3{value}\4'
    else:
        return content

    new_content, count = re.subn(pattern, replacement, content, count=1, flags=re.MULTILINE)
    if count > 0:
        print(f"Successfully updated {key} to {value}")
    else:
        print(f"Warning: Could not find or update {key} in {VARS_FILE}")
    
    return new_content

def main():
    content = read_file()
    variables = parse_variables(content)
    
    parser = argparse.ArgumentParser(
        description="Hyprland Configuration Manager (Dynamically parses variables.lua)",
        epilog="Example: ./manager.py --ColorScheme dracula --AnimateStyle snappy --groupBar false"
    )
    
    for key, info in variables.items():
        if info["type"] == "int":
            parser.add_argument(f"--{key}", type=int, help=info["help"])
        else:
            parser.add_argument(f"--{key}", type=str, help=info["help"])

    args, unknown = parser.parse_known_args()
    
    if len(sys.argv) == 1:
        parser.print_help()
        sys.exit(1)
        
    if unknown:
        print(f"Warning: Unknown arguments provided: {unknown}")
        
    modified = False
    for key, info in variables.items():
        val = getattr(args, key, None)
        if val is not None:
            content = update_var(content, key, val, info["type"])
            modified = True
            
    if modified:
        write_file(content)
        import subprocess
        sync_script = os.path.expanduser("~/.config/quickshell/sync_colors.py")
        if os.path.exists(sync_script):
            subprocess.run([sys.executable, sync_script])

if __name__ == "__main__":
    main()
