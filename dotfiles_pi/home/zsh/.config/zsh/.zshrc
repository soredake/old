# shellcheck disable=2034,2148
export PATH="${PATH}:$HOME/bin:/sbin:/usr/sbin"

# enable completion for hidden f{iles,olders}
# https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders
_comp_options+=(globdots)

for f in $HOME/.private/*; do . $f; done

# Don't hash directories on the path a time, which allows new
# binaries in $PATH to be executed without rehashing.
setopt nohashdirs

# No global match, no more "zsh: not found"
unsetopt nomatch

# Not autocomplete /etc/hosts, https://unix.stackexchange.com/questions/14155/ignore-hosts-file-in-zsh-ssh-scp-tab-complete
zstyle ':completion:*:hosts' hosts off

# https://stackoverflow.com/questions/14307086/tab-completion-for-aliased-sub-commands-in-zsh-alias-gco-git-checkout/20643204#20643204
setopt COMPLETE_ALIASES

# Less cannot create the needed folders
[[ ! -d "$XDG_CACHE_HOME/less" ]] && mkdir "$XDG_CACHE_HOME/less"

# clear terminal on exit
exithook() {
  printf "\033c"
  # or echo -e \\033c
}
# https://stackoverflow.com/questions/18221348/exit-hook-working-both-on-bash-and-zsh
# do not use a zsh way
trap exithook EXIT

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards.
#[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;
