import os
import subprocess
import framework
from pathlib import Path
from typing import List

HOME = os.path.expanduser("~")
WALLPAPERS_DIR = Path(f"{HOME}/Pictures/Wallpapers")
MATUGEN_SCRIPT = f"{HOME}/.config/scripts/matugen/matugen.sh"

FOLDER_CONFIG = {
    "Beige": {"color": "#f5f5dc", "icon": ""},
    "Black": {"color": "#1e1e2e", "icon": ""},
    "Blue": {"color": "#89b4fa", "icon": ""},
    "Cyan": {"color": "#94e2d5", "icon": ""},
    "Green": {"color": "#a6e3a1", "icon": ""},
    "Orange": {"color": "#fab387", "icon": ""},
    "Pink": {"color": "#f5c2e7", "icon": ""},
    "Red": {"color": "#f38ba8", "icon": ""},
    "Violet": {"color": "#cba6f7", "icon": ""},
    "White": {"color": "#ffffff", "icon": ""},
    "Yellow": {"color": "#f9e2af", "icon": ""},
}

def set_wallpaper(path: str):
    subprocess.run(["bash", MATUGEN_SCRIPT, path])

def get_wallpaper_nodes(folder: Path) -> List[framework.Node]:
    exts = (".jpg", ".png", ".jpeg", ".webp", ".JPG", ".PNG")
    if not folder.exists():
        return []

    files = sorted([f for f in folder.iterdir() if f.is_file() and f.suffix.lower() in exts])

    return [
        framework.Action(
            name=f.name,
            command=lambda p=str(f): set_wallpaper(p),
            icon=str(f),
            exit=True
        ) for f in files
    ]

def get_nodes() -> List[framework.Node]:
    if not WALLPAPERS_DIR.exists():
        return []

    folders = sorted([d for d in WALLPAPERS_DIR.iterdir() if d.is_dir()])
    nodes = []

    for folder in folders:
        conf = FOLDER_CONFIG.get(folder.name, {"color": "#ffffff", "icon": ""})
        
        node = framework.Parent(
            name=folder.name,
            icon=conf['icon'],
            children=lambda f=folder: get_wallpaper_nodes(f)
        )
        # Просто прокидываем цвет атрибутом, 
        # чтобы основной скрипт покрасил иконку сам
        node.color = conf['color']
        
        nodes.append(node)
        
    return nodes
