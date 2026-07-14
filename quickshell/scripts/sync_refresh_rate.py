#!/usr/bin/env python3
import os
import re
import subprocess

hyprland_lua = os.path.expanduser("~/Dotfiles/hypr/hyprland.lua")
vars_js = os.path.expanduser("~/Dotfiles/quickshell/Variables/variables.js")

refresh_rate = 240

if os.path.exists(hyprland_lua):
    with open(hyprland_lua, "r") as f:
        content = f.read()
        match = re.search(r'mode\s*=\s*"[^"]*@(\d+)"', content)
        if match:
            refresh_rate = int(match.group(1))

if os.path.exists(vars_js):
    with open(vars_js, "r") as f:
        content = f.read()
    
    if "var animationDuration =" in content:
        content = re.sub(r'var animationDuration = \d+;', f'var animationDuration = {refresh_rate};', content)
    else:
        content = f'var animationDuration = {refresh_rate};\n' + content
        
    with open(vars_js, "w") as f:
        f.write(content)
    print(f"Updated animationDuration to {refresh_rate} in variables.js")

# Reload Quickshell
subprocess.run("omniformis qs kill; omniformis qs start -d", shell=True)
