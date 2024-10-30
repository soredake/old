# Tasks for starting and stopping lycheefix
Unregister-ScheduledTask -TaskName "Start lycheefix" -Confirm:$false
Register-ScheduledTask -Principal (New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount -RunLevel Highest) -Action (New-ScheduledTaskAction -Execute (where.exe run-hidden.exe) -Argument "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe -c lycheefixon") -TaskName "Start lycheefix"
Unregister-ScheduledTask -TaskName "Stop lycheefix" -Confirm:$false
Register-ScheduledTask -Principal (New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount -RunLevel Highest) -Action (New-ScheduledTaskAction -Execute (where.exe run-hidden.exe) -Argument "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe -c lycheefixoff") -TaskName "Stop lycheefix"


function lycheefixon {
  Stop-Service -Name Hamachi2Svc
  Get-NetAdapter | Where-Object { $_.Name -ne "Ethernet 3" } | Disable-NetAdapter -Confirm:$false
}
function lycheefixoff {
  Start-Service -Name Hamachi2Svc
  Get-NetAdapter | Enable-NetAdapter
}
function StartLycheeFix {
  Start-ScheduledTask -TaskName "Start lycheefix"
}
function StopLycheeFix {
  Start-ScheduledTask -TaskName "Stop lycheefix"
}


function checklinks {
  #StartLycheeFix
  #StopLycheeFix
}
