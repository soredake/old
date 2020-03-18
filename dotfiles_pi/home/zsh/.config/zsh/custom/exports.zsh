# shellcheck disable=2034,2148

# Keep a reasonably long history.
export HISTSIZE=0;

# Keep even more history lines inside the file, so we can still look up
# previous commands without needlessly cluttering the current shell's history.
export HISTFILESIZE=0;

# When executing the same command twice or more in a row, only store it once.
# export HISTCONTROL=ignoredups;
# Ignore commands that start with spaces and duplicates
export HISTCONTROL=ignoreboth

# Keep track of the time the commands were executed.
# The xterm colour escapes require special care when piping; e.g. "| less -R".
export HISTTIMEFORMAT="${FG_BLUE}${FONT_BOLD}%Y/%m/%d %H:%M:%S${FONT_RESET}  ";

# Make some commands not show up in history.
export HISTIGNORE="ls:cd:cd:ll:ls:la:history -:pwd:exit:date:* --help";

# Make new shells get the history lines from all previous shells instead of the
# default "last window closed" history.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Ranger settings
export RANGER_LOAD_DEFAULT_RC=false
export W3MIMGDISPLAY_PATH="/usr/libexec/w3m/w3mimgdisplay"

# xdg
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
