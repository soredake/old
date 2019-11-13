# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# Help firefox
alias fxhelp='find $HOME/.mozilla/firefox -name "*.sqlite" -print -exec sqlite3 {} "VACUUM; REINDEX;" \;'

# find broken symlinks
alias badlinks='find . -type l -exec test ! -e {} \; -print'

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias xsel='xsel --logfile $XDG_CACHE_HOME/xsel/xsel.log'

# Color ls.
alias ls='ls --color=auto -ah --quoting-style=escape --group-directories-first'

# Timer.
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"

# What's my IP address.
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Enhanced WHOIS lookups.
alias whois='whois -h whois.internic.net'

# Confirm before overwriting
# I know it is bad practice to override the default commands, but this is for
# my own safety. If you really want the original "instakill" versions, you can
# use "command rm", "\rm", or "/bin/rm" inside your own commands, aliases, or
# shell functions. Note that separate scripts are not affected by the aliases
# defined here.
alias omv='/bin/mv -i'
alias rm='/bin/rm -i'
alias ocp='/bin/cp -i'

# Better copy, move, copy with update and synchronize folder aliases
# --archive = archive mode; equals -rlptgoD (no -H,-A,-X)
alias mrsync='rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h'
alias cp='mrsync'
alias mv='mrsync --remove-source-files'
alias cpu='mrsync --update'
alias cps='mrsync --update --delete'

# Folder size
alias fosize='du -sh'

# similar to ubuntu's update-grub
alias update-grub='test ! -d /boot/grub && sudo mount /boot; sudo grub-mkconfig -o /boot/grub/grub.cfg && sudo umount /boot'

# docker-gc with options
alias docker-gc='PID_DIR="$XDG_RUNTIME_DIR" STATE_DIR="$XDG_CACHE_HOME/docker-gc" FORCE_IMAGE_REMOVAL=1 FORCE_CONTAINER_REMOVAL=1 EXCLUDE_FROM_GC="" EXCLUDE_CONTAINERS_FROM_GC="" GRACE_PERIOD_SECONDS=300 docker-gc'

# perms quick-fix
alias dir755='find . -type d -exec chmod 755 {} +'
alias dir700='find . -type d -exec chmod 700 {} +'
alias files644='find . -type f -exec chmod 644 {} +'
alias files600='find . -type f -exec chmod 600 {} +'

# owner quick-fix
alias owneruser='chown -R $(id -u):$(id -g) .'

# git aliases
alias gitpushsingle='git add -A; git commit -v -m "$(LANG=en date '+%d/%m/%Y')"; git push'
# https://github.com/robbyrussell/oh-my-zsh/pull/5026
alias gsmc='git diff --name-only --diff-filter=U'
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} candp \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'

# Mpv aliases, mpv as image viewer, simple and quiet mpv.
alias mvi='mpv --profile image'
alias mpvs='mpv --vo=opengl'
alias mpvqs='mpvq --vo=opengl'

# things...
alias internal-ip='ip addr show enp30s0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1'

# Shorter
alias e='atom'
#alias grep='grep --color'
alias goodnight='veracrypt -t -d && "$HOME/mdata/syncthing/system-data/backup.sh" -f && sc poweroff'
alias o='open'
alias ob='bkg xdg-open'
alias open='xdg-open'
alias px='proxychains -q'
alias sl='streamlink'
alias mutt='px mutt -F ~/.config/mutt/config'

# stuff
alias jc='journalctl'
alias sc='systemctl'
alias scu='sc --user'
alias jcu='jc --user'
