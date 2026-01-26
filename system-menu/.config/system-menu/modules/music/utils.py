import subprocess, time

def stop_music_logic():
    try:
        subprocess.run(["mpc", "stop"], capture_output=True, timeout=1)
    except:
        subprocess.run(["pkill", "-9", "mpd"], capture_output=True)
        time.sleep(0.5)
        subprocess.run(["systemctl", "--user", "restart", "mpd"], capture_output=True)

    subprocess.run(["mpc", "clear"], capture_output=True)
    for proc in ["mpd-mpris", "rmpc", "yamusic_mpd.py"]:
        subprocess.run(["pkill", "-f", proc], capture_output=True)
    subprocess.run(["hyprctl", "dispatch", "closewindow", "class:^music_player$"], capture_output=True)
    return True

def is_playing() -> bool:
    try:
        res = subprocess.run(["mpc", "status"], capture_output=True, text=True, timeout=0.2)
        return "playing" in res.stdout
    except:
        return False
