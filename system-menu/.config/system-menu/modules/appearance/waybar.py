import os
import subprocess
from pathlib import Path

HOME = Path.home()
WAYBAR_THEMES_DIR = HOME / ".config/waybar/themes"
WAYBAR_COMPONENTS_DIR = HOME / ".config/waybar/components"

# В файле waybar.py
def set_symlink(folder: Path, file_stem: str, extension: str, symlink_target: str):
    source = folder / f"{file_stem}{extension}"
    target = WAYBAR_COMPONENTS_DIR / symlink_target
    try:
        if target.exists() or target.is_symlink():
            target.unlink()
        target.symlink_to(source)
        # Попробуйте pkill, если killall капризничает
        subprocess.run(["pkill", "-SIGUSR2", "waybar"], stderr=subprocess.DEVNULL)
    except Exception as e:
        print(f"Waybar error: {e}")

def get_current_stem(symlink_target: str) -> str:
    """Читает текущее состояние из симлинка"""
    target = WAYBAR_COMPONENTS_DIR / symlink_target
    if target.exists() and target.is_symlink():
        return Path(os.readlink(target)).stem
    return ""

def get_files_in(folder_path: Path, extension: str):
    """Возвращает список имен файлов для Action"""
    if not folder_path.exists():
        return []
    return [f.stem for f in sorted(folder_path.glob(f"*{extension}"))]
