import os
import subprocess
from .utils import stop_music_logic

HOME = os.path.expanduser("~")
PY_PATH = f"{HOME}/.config/yamusic/venv/bin/python"
SCRIPT_PATH = f"{HOME}/.config/yamusic/yamusic_mpd.py"

def run_music():
    stop_music_logic()

    # Уведомляем о начале
    subprocess.run(["notify-send", "Yandex Music", "Synchronizing library"])

    try:
        subprocess.run(
            [PY_PATH, SCRIPT_PATH],
            input="1\n500\n",
            text=True,
            capture_output=True,
            check=True
        )

        subprocess.run(["mpc", "update", "--wait"], check=True, capture_output=True)
        subprocess.run(["mpc", "play"], check=True, capture_output=True)
        subprocess.run(["notify-send", "Yandex Music", "Playback is started"])

    except subprocess.CalledProcessError as e:
        error_msg = e.stderr.strip() if e.stderr else "Unknown error during sync"
        subprocess.run(["notify-send", "-u", "critical", "Yandex Music Error", error_msg])
        print(f"Process error: {e}")
        return False

    except FileNotFoundError:
        subprocess.run(["notify-send", "-u", "critical", "Yandex Music", "Script paths not found!"])
        return False

    except Exception as e:
        subprocess.run(["notify-send", "-u", "critical", "Yandex Music", f"Unexpected error: {str(e)}"])
        return False

    return True
