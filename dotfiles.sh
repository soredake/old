#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null; pwd)";
cd "$SD" || exit 1

git pull origin master;

doIt() {
  # Copy the ".init/private" file only if it doesn't already exist.
  if [ ! -f "$HOME/.init/.private" ]; then
    cp "$SD/.init/.private" "$HOME/.init/.private"
  fi

  # Symlink some home config directories.
  symlinked_dirs_home=(
    .config/mpv
    .config/ranger
    .config/htop
    .tmuxinator
    .mozilla
  );
  for symlinked_dir_home in "${symlinked_dirs_home[@]}"; do
    if ! [[ -L "$HOME/$symlinked_dir_home" && -d "$HOME/$symlinked_dir_home" ]]; then
      ln -s "$SD/$HOMEDIR/$symlinked_dir_home" "$HOME/$symlinked_dir_home"
      echo "Create symlink from $HOMEDIR/$symlinked_dir_home to $HOME/$symlinked_dir_home"
    else
      echo "Link for $HOMEDIR/$symlinked_dir_home already exists"
    fi
  done;

  cd home/bausch || exit 1
  rsync --exclude ".atom/" --exclude ".init/" --exclude ".drush/" \
  --exclude ".git/" --exclude ".WebIde90/" --exclude ".config/" \
  --exclude ".mozilla/" --exclude ".tmuxinator/" --exclude "GIT.md" \
  --exclude "LICENSE" --exclude "README.md" \
  -avh --no-perms . ~;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  doIt;
else
  # Removed the '-n 1' flag to accept a single char without requiring "Enter" to
  # be pressed because I don't care much for it.
  read -p "This will overwrite existing files in your home directory. Are you sure? (y/n) ";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
