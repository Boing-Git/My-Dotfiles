import os

files = [
    '/home/boing/Dotfiles/quickshell/components/SettingsApp.qml',
    '/home/boing/Dotfiles/quickshell/components/ControlCenter.qml',
    '/home/boing/Dotfiles/quickshell/components/WallpaperSwitcher.qml'
]

for file_path in files:
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        content = content.replace('radius: 24', 'radius: 16')
        content = content.replace('height / 2 : 24', 'height / 2 : 16')
        content = content.replace('width: 24; height: 24; color: parent.color', 'width: 16; height: 16; color: parent.color')
        
        with open(file_path, 'w') as f:
            f.write(content)
        print(f"Updated {file_path}")
    except Exception as e:
        print(f"Failed to process {file_path}: {e}")
