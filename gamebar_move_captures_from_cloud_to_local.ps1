New-Item -ItemType Directory -Path "$env:USERPROFILE\GameBar-Captures" -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{EDC0FE71-98D8-4F4A-B920-C8DC133CB165}" -Value "$env:USERPROFILE\GameBar-Captures"
Stop-Process -Name explorer -Force
