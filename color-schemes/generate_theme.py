import os
import re
import sys

def parse_qml_theme(filepath):
    c = {}
    
    # Try to derive a clean theme name from the filename
    base_name = os.path.basename(filepath)
    name = base_name.replace('-light', '').replace('-dark', '').replace(' light', '').replace(' dark', '').replace('.qml', '').title()
    if not name:
        name = "AutoTheme"
        
    try:
        with open(filepath, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('//'): continue
                
                # Match `readonly property color key: "#hex"`
                match = re.search(r'readonly property color (\w+):\s*"([^"]+)"', line)
                if match:
                    key = match.group(1)
                    val = match.group(2)
                    c[key] = val
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        sys.exit(1)
        
    return c, name

def process_template(template_content, light_map, dark_map, is_dark_mode=True):
    pattern = r'\{\{\s*colors\.([a-zA-Z0-9_]+)\.(light|dark)\.hex[^\}]*\}\}'
    def replacer(match):
        color_name = match.group(1)
        mode = match.group(2)
        mapping = light_map if mode == 'light' else dark_map
        return mapping.get(color_name, '#000000')
        
    template_content = re.sub(pattern, replacer, template_content)
    template_content = re.sub(r'\{\{\s*image\s*\}\}', '/tmp/wallpaper.png', template_content)

    loop_pattern = r'<\*\s*for\s+name\s*,\s*value\s+in\s+colors\s*\*>(.*?)<\*\s*endfor\s*\*>'
    def loop_replacer(match):
        inner_template = match.group(1)
        result = []
        if 'value.dark' in inner_template:
            map_to_use = dark_map
        elif 'value.light' in inner_template:
            map_to_use = light_map
        else:
            map_to_use = dark_map if is_dark_mode else light_map
            
        for color_name, hex_val in map_to_use.items():
            hex_stripped = hex_val.lstrip('#')
            s = inner_template.replace('{{name}}', color_name)
            s = re.sub(r'\{\{\s*value\.(light|dark)\.hex_stripped[^\}]*\}\}', hex_stripped, s)
            s = re.sub(r'\{\{\s*value\.(light|dark)\.hex[^\}]*\}\}', hex_val, s)
            result.append(s)
        return "".join(result)
        
    template_content = re.sub(loop_pattern, loop_replacer, template_content, flags=re.DOTALL)
    return template_content

def main():
    if len(sys.argv) < 3:
        print("Usage: python generate_theme.py <light_theme.qml> <dark_theme.qml>")
        sys.exit(1)

    light_file = sys.argv[1]
    dark_file = sys.argv[2]
    
    light_map, light_name = parse_qml_theme(light_file)
    dark_map, dark_name = parse_qml_theme(dark_file)
    
    # Use the name from the light theme by default
    theme_name = light_name
    dir_name = theme_name.lower().replace(' ', '-')

    config_path = os.path.expanduser('~/.config/matugen/config.toml')
    if not os.path.exists(config_path):
        print(f"Error: {config_path} not found.")
        sys.exit(1)

    with open(config_path, 'r') as f:
        config_content = f.read()

    templates = []
    current_template = None
    for line in config_content.splitlines():
        line = line.strip()
        if not line or line.startswith('#'): continue
        if line.startswith('[templates.'):
            if current_template is not None:
                templates.append(current_template)
            current_template = {}
            continue
        if '=' in line and current_template is not None:
            k, v = line.split('=', 1)
            k = k.strip()
            v = v.strip().strip("'").strip('"')
            current_template[k] = v
            
    if current_template is not None:
        templates.append(current_template)

    matugen_dir = os.path.expanduser('~/.config/matugen/')
    for tmpl in templates:
        input_p = tmpl.get('input_path')
        output_p = tmpl.get('output_path')
        if not input_p or not output_p:
            continue

        in_path = os.path.normpath(os.path.join(matugen_dir, input_p.replace('./', '')))
        out_path = os.path.expanduser(output_p)
        out_path = out_path.replace('material-you', dir_name)

        if not os.path.exists(in_path):
            print(f"Warning: template not found {in_path}")
            continue

        with open(in_path, 'r') as f:
            content = f.read()

        is_dark = 'dark' in in_path
        new_content = process_template(content, light_map, dark_map, is_dark_mode=is_dark)

        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        with open(out_path, 'w') as f:
            f.write(new_content)

        print(f"Generated {out_path}")

    print(f"Theme '{theme_name}' generated successfully!")

if __name__ == '__main__':
    main()
