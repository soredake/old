Invoke-WebRequest -Uri "https://haali.net/winutils/lswitch.exe" -OutFile "$env:USERPROFILE/lswitch.exe"

# @echo off
# cd %~dp0
# start /B %USERPROFILE%\lswitch.exe 163

Invoke-WebRequest -Uri "https://gist.github.com/soredake/d35c1b5f02afbe844acffd7b26731fcb/raw/73458a76a28806ed878c277bed66815304000c96/lswitch.bat" -OutFile "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\lswitch.bat"
