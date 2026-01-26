import os
import json
import html
import subprocess
import time
from typing import List
import framework
from .utils import stop_music_logic

HOME = os.path.expanduser("~")
STREAMS_JSON = os.path.join(HOME, ".config/system-menu/modules/music/radio.json")

def play_radio(name: str, url: str):
    stop_music_logic()
    subprocess.run(["mpc", "add", url], capture_output=True)
    time.sleep(0.4)
    subprocess.run(["mpc", "play"], capture_output=True)
    subprocess.Popen(["mpd-mpris", "-host", "127.0.0.1", "-port", "6600"],
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(["hyprctl", "dispatch", "exec", "[workspace special:magic silent] kitty --class music_player -e rmpc"])
    return True

def get_nodes() -> List[framework.Node]:
    if not os.path.exists(STREAMS_JSON):
        return [framework.Action("Missing JSON", lambda: None)]
    with open(STREAMS_JSON, "r") as f:
        streams = json.load(f)
    return [
        framework.Action(html.escape(s["name"]), lambda n=s["name"], u=s["url"]: play_radio(n, u), exit=True)
        for s in streams
    ]
