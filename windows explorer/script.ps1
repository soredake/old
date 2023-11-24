function documentsfoldertyperecursively {
  # https://github.com/microsoft/PowerToys/issues/26297
  # https://github.com/microsoft/PowerToys/issues/25547
  # https://superuser.com/questions/738978/how-to-prevent-windows-explorer-from-slowly-reading-file-content-to-create-metad
  # https://superuser.com/questions/487647/sorting-by-date-very-slow
  # https://stackoverflow.com/a/32058202/4207635
  $dirs = Get-ChildItem -Directory -Recurse -Path (Read-Host -Prompt 'Enter the full name of the directory you want to copy to')
  foreach ($dir in $dirs) {
    Copy-Item ~\git\dotfiles_windows\misc\explorer-folder-type-documents.ini "$dir\desktop.ini"
  }
}
