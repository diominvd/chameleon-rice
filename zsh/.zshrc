export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls="eza -1 --header --icons --hyperlink"
alias cat="bat"
alias cls="clear"

# Apps
alias ff="fastfetch"
alias typing="typetea start"
alias systemdtui="sudo systemd-manager-tui"
alias speed="cloudflare-speed-cli"

# Utilites
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias mpdr='echo "> Restarting MPD & cleaning up..."; \
    pkill -f "mpd-mpris" || true; \
    pkill -f "rmpc" || true; \
    pkill -f "yamusic_mpd.py" || true; \
    systemctl --user restart mpd && \
    sleep 0.5 && \
    mpc clear && \
    echo "> MPD is fresh now."'

# Scripts
alias mypackages="~/.config/scripts/sys-menu/maintenance/packages.sh"
alias update="sudo ~/.config/scripts/sys-menu/maintenance/update.sh"
alias pclean="sudo ~/.config/scripts/sys-menu/maintenance/clean.sh"

# Variables
export HISTFILE="$HOME/.cache/zsh_history"
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$HOST-$ZSH_VERSION"
export NVIDIA_SETTINGS_RW_DIR="$XDG_CONFIG_HOME"
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

TRAPUSR1() {
  zle && zle reset-prompt
}
