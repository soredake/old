#!/usr/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null; pwd)";
cd "$SD" || exit 1

XC=${XDG_CONFIG_HOME:-${HOME}/.config}

doIt() {
  # Copy the ".init/private" file only if it doesn't already exist.
  if [[ ! -f "$HOME/.init/.private" ]]; then
    cp -r "$SD/home_cp/.init" "$HOME"
  else
    echo ".private exists, skipping..."
  fi

  # Copy the "$XDG_CONFIG_HOME/git/config" file only if it doesn't already exist.
  if [[ ! -f "$XC/git/config" ]]; then
    mkdir "$XC/git"
    cp "$SD/home_cp/.gitconfig" "$XC/git/config"
  else
    echo "$XC/git/config exists, skipping"
  fi

  # Symlink some home config directories.
  symlinked_dirs_home=(
    bin
  );
  for symlinked_dir_home in "${symlinked_dirs_home[@]}"; do
    if ! [[ -L "$HOME/$symlinked_dir_home" && -d "$HOME/$symlinked_dir_home" ]]; then
      ln -s "$SD/$HOMEDIR/$symlinked_dir_home" "$HOME/$symlinked_dir_home"
      echo "Create symlink from $HOMEDIR/$symlinked_dir_home to $HOME/$symlinked_dir_home"
    else
      echo "Link for $HOMEDIR/$symlinked_dir_home already exists"
    fi
  done;

  cd home || exit 1
  rsync --exclude "bin" \
  --exclude "GIT.md" \
  --exclude "LICENSE" --exclude "README.md" \
  -avh --no-perms . "$HOME";
}

if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
  doIt;
else
  read -p "This will overwrite existing files in your home directory. Are you sure? (y/n) ";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
