set -g fundle true
if test $fundle=true;
  not test -d $XDG_DATA_HOME/fundle; and git clone --depth 1 https://github.com/tuvistavie/fundle $XDG_DATA_HOME/fundle
  source $XDG_DATA_HOME/fundle/functions/fundle.fish
  fundle plugin 'rafaelrinaldi/pure'
  #zplug "plugins/extract", from:oh-my-zsh
  #zplug "pepa65/tldr-bash-client", as:command, use:"tldr"

  # Then, source plugins and add commands to $PATH
  fundle init

  fundle install

  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias .....='cd ../../../..'
  alias ......='cd ../../../../..'

  alias 1='cd -'
  alias 2='cd -2'
  alias 3='cd -3'
  alias 4='cd -4'
  alias 5='cd -5'
  alias 6='cd -6'
  alias 7='cd -7'
  alias 8='cd -8'
  alias 9='cd -9'
  alias d='dirs -v | head -10'

  # List directory contents
  alias lsa='ls -lah'
  alias l='ls -lah'
  alias ll='ls -lh'
  alias la='ls -lAh'

  #for f in $XDG_CONFIG_HOME/fish/custom/*; source $f; end
end

# Set PATH
set -gx PATH $HOME/bin /usr/sbin /sbin $PATH

#for f in $HOME/.private/*; source $f; end

# less cannot create the needed folders itself
not test -d $XDG_CACHE_HOME/less

echo Hi sempai~
