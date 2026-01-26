#!/usr/bin/env python3
import subprocess
import framework
from typing import List

def get_nodes() -> List[framework.Node]:
    cmd = "grep -h 'Name=' /usr/share/applications/*.desktop $HOME/.local/share/applications/*.desktop 2>/dev/null | cut -d'=' -f2 | sort -u"

    try:
        apps_names = subprocess.check_output(cmd, shell=True, text=True).strip().split('\n')
    except Exception:
        return []

    nodes = []
    seen_names = set()

    for name in apps_names:
        name = name.strip()
        if not name or name in seen_names:
            continue

        launch_cmd = f"gtk-launch \"$(grep -l 'Name={name}' /usr/share/applications/*.desktop $HOME/.local/share/applications/*.desktop | head -n 1 | xargs basename)\""

        nodes.append(framework.Action(name, launch_cmd, icon="", exit=True))
        seen_names.add(name)

    nodes.sort(key=lambda x: x.name.lower())
    return nodes
