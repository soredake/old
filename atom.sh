#!/bin/bash

packages=(
  advanced-open-file
  atom-beautify
  color-picker
  editorconfig
  file-icons
  firewatch-syntax
  git-time-machine
  language-babel
  language-diff
  language-fish-shell
  language-generic-config
  language-systemd
  language-tmux
  linter
  linter-bootlint
  linter-shellcheck
  minimap
  minimap-cursorline
  minimap-find-and-replace
  minimap-linter
  minimap-pigments
  minimap-selection
  permanent-delete
  pigments
  pinned-tabs
  prettier-atom
  sort-lines
  source-preview
  tree-view-git-status
  tree-view-search-bar
)

apm i "${packages[@]}"
