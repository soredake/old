# Ranger settings
set -gx RANGER_LOAD_DEFAULT_RC false

# for xdg-open
set -gx BROWSER 'firefox'

# xdg
set -gx MPD_HOST $XDG_RUNTIME_DIR/mpd/socket
set -gx GNUPGHOME $XDG_CONFIG_HOME/gnupg
set -gx LESSHISTFILE $XDG_CACHE_HOME/less/history
set -gx PROXYCHAINS_CONF_FILE $XDG_CONFIG_HOME/proxychains.conf
