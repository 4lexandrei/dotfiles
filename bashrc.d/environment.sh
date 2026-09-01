# ┌─────────────┐
# │ Environment │
# └─────────────┘

source "$(dirname "${BASH_SOURCE[0]}")/lib/path.sh"

# Custom PATH
path_prepend "$HOME/.local/bin"

export GTK_THEME=Adwaita:dark

# --- Development configurations ---

# Adds Rust to PATH
# shellcheck disable=SC1091
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# Adds Android platform-tools to PATH
if [[ -d "$HOME/Android/Sdk/platform-tools" ]]; then
  path_append "$HOME/Android/Sdk/platform-tools"
fi
export ANDROID_HOME=$HOME/Android/Sdk/

# SDL
export SDL_VIDEODRIVER=wayland

# Esp-IDF
export IDF_CCACHE_ENABLE=true
