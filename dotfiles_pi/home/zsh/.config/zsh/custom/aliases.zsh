# shellcheck disable=2034,2148
# Color ls.
alias ls='ls --color=auto -ah --quoting-style=escape'

# Git.
alias g='git'

# Timer
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Update everything
alias update='sudo emerge --sync && sudo eix-update && sudo emerge -uDU @world && sudo emerge @preserved-rebuild && sudo emerge -av --depclean && sudo env-update && sudo eclean -d distfiles && sudo glsa-check -l affected && sudo python-updater && sudo perl-cleaner --all'

# What's my IP address.
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Enhanced WHOIS lookups.
alias whois='whois -h whois.internic.net'

# docker-gc with options
alias docker-gc='PID_DIR="$XDG_RUNTIME_DIR" STATE_DIR="$XDG_CACHE_HOME/docker-gc" FORCE_IMAGE_REMOVAL=1 FORCE_CONTAINER_REMOVAL=1 EXCLUDE_FROM_GC="" EXCLUDE_CONTAINERS_FROM_GC="" GRACE_PERIOD_SECONDS=300 docker-gc'

# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# Confirm before overwriting
# I know it is bad practice to override the default commands, but this is for
# my own safety. If you really want the original "instakill" versions, you can
# use "command rm", "\rm", or "/bin/rm" inside your own commands, aliases, or
# shell functions. Note that separate scripts are not affected by the aliases
# defined here.
alias ocp='\cp -i'
alias omv='\mv -i'

# Better copy, move, copy with update and synchronize folder aliases
alias mrsync='rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h'
alias cp='mrsync'
alias mv='mrsync --remove-source-files'
alias cpu='mrsync --update'
alias cps='mrsync --update --delete'

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
