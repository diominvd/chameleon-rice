#!/usr/bin/env python3
import os
import re
import subprocess
import math
import framework
from dataclasses import dataclass
from typing import List

HOME = os.path.expanduser("~")
SCRIPTS_DIR = f"{HOME}/.config/scripts/system-menu_scripts"

@dataclass(frozen=True)
class RofiTheme:
    ELEMENT_HEIGHT = 36.0
    ELEMENT_PADDING_V = 8.0
    ELEMENT_PADDING_H = 12.0
    LISTVIEW_SPACING = 4.0
    MAINBOX_PADDING = 15.0
    WINDOW_BORDER = 2.0
    INPUTBAR_MARGIN_BOTTOM = 12.0

    DEFAULT_WIDTH = 300
    DEFAULT_LINES = 15
    WIDTH_CONFIG = {"Search": 700, "Apps": 400, "Radio": 400}
    LINES_CONFIG = {"Search": 8, "Apps": 6}

    ACCENT_COLOR = "@accent"
    SECONDARY_TEXT_COLOR = "#6272a4"
    ICON_SIZE_DEFAULT = 20
    ICON_SIZE_PREVIEW = 20

    @classmethod
    def get_width(cls, node_name: str) -> int:
        return cls.WIDTH_CONFIG.get(node_name, cls.DEFAULT_WIDTH)

    @classmethod
    def get_lines_limit(cls, node_name: str) -> int:
        return cls.LINES_CONFIG.get(node_name, cls.DEFAULT_LINES)

def clean_selection_name(selection: str) -> str:
    """Очистка строки для поиска объекта в списке items"""
    res = selection.split("\0icon")[0]
    if "\t" in res:
        res = res.split("\t")[0]
    res = re.sub(r'<[^>]+>', '', res)
    if ":" in res:
        res = res.split(":")[0]
    res = res.strip()
    if "  " in res:
        parts = res.split("  ", 1)
        if len(parts) > 1:
            res = parts[1]
    return res.strip()

def calculate_window_height(item_count: int, max_lines: int, has_search: bool) -> int:
    t = RofiTheme
    display_lines = min(item_count if item_count > 0 else 1, max_lines)
    listview_h = (display_lines * t.ELEMENT_HEIGHT) + (max(0, display_lines - 1) * t.LISTVIEW_SPACING)
    inputbar_h = (t.ELEMENT_HEIGHT + t.INPUTBAR_MARGIN_BOTTOM) if has_search else 0.0
    return math.ceil((t.MAINBOX_PADDING * 2) + inputbar_h + listview_h + (t.WINDOW_BORDER * 2) + 12.0)

def build_rofi_theme(height: int, lines: int, has_search: bool, width: int, show_icons: bool) -> str:
    t = RofiTheme
    icon_size = t.ICON_SIZE_PREVIEW if show_icons else t.ICON_SIZE_DEFAULT
    icon_css = f"enabled: true; size: {icon_size}px; margin: 0 12px 0 0;" if show_icons else "enabled: false;"
    return f"""
        configuration {{ show-icons: {'true' if show_icons else 'false'}; }}
        window {{ width: {width}px; height: {height}px; border: {t.WINDOW_BORDER}px; }}
        mainbox {{ padding: {t.MAINBOX_PADDING}px; spacing: 0px; children: [ {'"inputbar", ' if has_search else ''}"listview" ]; }}
        listview {{ lines: {lines}; fixed-height: false; spacing: {t.LISTVIEW_SPACING}px; scrollbar: false; border: 0px; }}
        element {{ padding: {t.ELEMENT_PADDING_V}px {t.ELEMENT_PADDING_H}px; border-radius: 12px; }}
        element selected {{ border: 0 0 0 2px; border-color: {t.ACCENT_COLOR}; border-radius: 0px; }}
        element-icon {{ {icon_css} }}
        element-text {{ vertical-align: 0.5; markup: true; expand: true; }}
        inputbar {{ enabled: {'true' if has_search else 'false'}; padding: {t.ELEMENT_PADDING_V}px {t.ELEMENT_PADDING_H}px; margin: 0 0 {t.INPUTBAR_MARGIN_BOTTOM}px 0; }}
    """

def show_menu(node: framework.Parent, path_names: List[str] = None):
    actual_path = path_names or []
    while True:
        items = node.get_children()
        is_inside_wallpapers = "Wallpapers" in actual_path
        show_icons = is_inside_wallpapers and any(i.icon and ("/" in i.icon or "." in i.icon) for i in items)

        menu_lines = []
        for i in items:
            name_part = i.render()
            item_color = getattr(i, 'color', None)
            if item_color:
                color_val = "#ffff00" if item_color == "yellow" else item_color
                name_part = f"<span foreground='{color_val}'>{name_part}</span>"

            if node.name == "Search" and i.icon and ("/" in i.icon or "." in i.icon):
                line = f"{name_part}\t<span alpha='50%' foreground='{RofiTheme.SECONDARY_TEXT_COLOR}' size='small'>{i.icon}</span>"
            else:
                line = name_part

            if show_icons and i.icon:
                line += f"\0icon\x1f{i.icon}"
            menu_lines.append(line)

        win_h = calculate_window_height(len(items), RofiTheme.get_lines_limit(node.name), node.search)
        theme = build_rofi_theme(win_h, min(len(items) or 1, RofiTheme.get_lines_limit(node.name)), node.search, RofiTheme.get_width(node.name), show_icons)

        cmd = ["rofi", "-dmenu", "-markup-rows", "-i", "-p", actual_path[-1] if actual_path else "System", "-theme-str", theme,
               "-kb-move-char-back", "", "-kb-move-char-forward", "", "-kb-custom-1", "Left", "-kb-accept-entry", "Return,KP_Enter,Right"]

        proc = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
        stdout, _ = proc.communicate(input="\n".join(menu_lines))

        if proc.returncode in [1, -1] or not stdout:
            return "EXIT"
        if proc.returncode == 10:
            return "BACK"

        sel = clean_selection_name(stdout.strip())
        target = next((i for i in items if i.name == sel), None)
        if not target:
            continue

        if isinstance(target, framework.Parent):
            if show_menu(target, actual_path + [target.name]) == "EXIT":
                return "EXIT"
        elif isinstance(target, framework.Action):
            if target.execute():
                return "EXIT"
        elif isinstance(target, framework.Toggle):
            target.toggle()
            continue

def get_waybar_node(waybar_mod):
    def make_t(name, symlink, folder_path, ext):
        f = waybar_mod.WAYBAR_THEMES_DIR / folder_path
        return framework.Toggle(
            name=name, icon="",
            states=waybar_mod.get_files_in(f, ext),
            get_state=lambda: waybar_mod.get_current_stem(symlink),
            set_state=lambda s: waybar_mod.set_symlink(f, s, ext, symlink)
        )

    return framework.Parent("Waybar", icon="", children=[
        framework.Parent("Panel settings", icon="󰻵", children=[
            make_t("Color", "panel-color.css", "panel/colors", ".css"),
            make_t("Position", "panel-position.jsonc", "panel/positions", ".jsonc"),
            make_t("Shape", "panel-shape.css", "panel/shapes", ".css"),
            framework.Parent("Presets", icon="", search=True, children=lambda: [
                framework.Action(name=n, command=lambda x=n: waybar_mod.set_symlink(waybar_mod.WAYBAR_THEMES_DIR / "panel/presets", x, ".jsonc", "panel-preset.jsonc"))
                for n in waybar_mod.get_files_in(waybar_mod.WAYBAR_THEMES_DIR / "panel/presets", ".jsonc")
            ])
        ]),
        framework.Parent("Widgets settings", icon="󰆦", children=[
            make_t("Color", "widgets-color.css", "widgets/colors", ".css"),
            make_t("Shape", "widgets-shape.css", "widgets/shapes", ".css"),
        ])
    ])

if __name__ == "__main__":
    from modules.apps import apps
    from modules.music import utils, radio, yandex_music
    from modules.appearance import wallpapers, waybar

    def get_root_nodes():
        items = []
        if utils.is_playing():
            items.append(framework.Action("Stop Music", icon="󰓛", command=utils.stop_music_logic))

        items.extend([
            framework.Parent("Apps", icon="󰀻", search=True, children=apps.get_nodes()),
            framework.Parent("Music", icon="", children=[
                framework.Action("Yandex Music", yandex_music.run_music, icon="", exit=True),
                framework.Parent("Radio", icon="", search=True, children=radio.get_nodes())
            ]),
            framework.Parent("Appearance", icon="", children=[
                framework.Parent("Wallpapers", icon="", search=True, children=wallpapers.get_nodes()),
                get_waybar_node(waybar)
            ]),
            framework.Parent("Maintenance", icon="󰒓", children=[
                framework.Action("Systemd", "kitty --hold -e systemd-manager-tui", icon="", exit=True),
                framework.Action("Packages", f"{SCRIPTS_DIR}/installed_packages.sh", icon="", exit=True),
                framework.Action("Update system", f"{SCRIPTS_DIR}/update_system.sh", icon="", color="yellow", exit=True),
                framework.Action("Clean cache", f"kitty --title='cleaner' -e {SCRIPTS_DIR}/clean_cache/clean_cache.py", icon="", color="yellow", exit=True)
            ]),
            framework.Parent("Capture", icon="", children=[
                framework.Action("Record screen", f"{SCRIPTS_DIR}/record_screen.sh", icon="", exit=True),
                framework.Action("Full screenshot", f"{SCRIPTS_DIR}/make_full_screenshot.sh", icon="", exit=True),
            ]),
            framework.Parent("Power menu", icon="", children=[
                framework.Action("Lock", "hyprlock", icon="", exit=True),
                framework.Action("Logout", "hyprctl dispatch exit", icon="󰍃", exit=True),
                framework.Action("Reboot", "systemctl reboot", icon="", color="red", exit=True),
                framework.Action("Poweroff", "systemctl poweroff", icon="󰚦", color="red", exit=True),
            ])
        ])
        return items

    show_menu(framework.Parent("Main", children=get_root_nodes, search=False))
