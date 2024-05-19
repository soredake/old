# https://github.com/CogentRedTester/mpv-sub-select/issues/30
(Get-Content "$env:APPDATA\mpv.net\scripts\sub-select.lua") -replace 'force_prediction = false', 'force_prediction = true' | Set-Content "$env:APPDATA\mpv.net\scripts\sub-select.lua"

# TODO: make MPV command name configurable
(Get-Content "$env:APPDATA\mpv.net\scripts\webm.lua") -replace '"mpv"', '"mpvnet.exe"' | Set-Content "$env:APPDATA\mpv.net\scripts\webm.lua"

curl -L --create-dirs --remote-name-all --output-dir $env:APPDATA\mpv.net\scripts "https://github.com/serenae-fansubs/mpv-webm/releases/download/latest/webm.lua" "https://codeberg.org/jouni/mpv_sponsorblock_minimal/raw/branch/master/sponsorblock_minimal.lua" "https://raw.githubusercontent.com/zenwarr/mpv-config/master/scripts/russian-layout-bindings.lua" "https://github.com/CogentRedTester/mpv-sub-select/raw/reset-auto/sub-select.lua"
