# shellcheck disable=2034,2148

# When executing the same command twice or more in a row, only store it once.
# Ignore commands that start with spaces and duplicates
export HISTCONTROL=ignoreboth

# Set default programs
# editor
export EDITOR=codium
# browser for xdg-open
export BROWSER=firefox

# zsh-autosuggest plugin settings
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20