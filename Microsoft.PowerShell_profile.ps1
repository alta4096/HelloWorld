function Global:prompt {
$ProfileHash= [ordered]@{
'ProfilePSheader' = "[PS]"
'AdminState' = $(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
'DateFormatU' = $(get-date -Format u)
'Battery'= $((Get-WmiObject win32_battery).estimatedChargeRemaining)
'NetworkConnectivityWifi' = $($(Get-NetAdapter | Where-Object {$_.Name -eq 'Wi-Fi'}) | ForEach-Object{$_.name, $_.MediaConnectionState, $_.status})
'MeasureCommandMs' = $($(Measure-Command -Expression { Invoke-History}).TotalMilliseconds)
'HistoryCommandLine' = $((get-history -count 1).CommandLine)
'CurrentLocation' = $((Get-Location).Path)
'ProfilePSFooter' = "]>"
}

write-host $ProfileHash.ProfilePSheader -foregroundcolor white -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host $ProfileHash.DateFormatU -foregroundcolor Cyan -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host ("IsAdmin:",$ProfileHash.AdminState) -foregroundcolor $(if($ProfileHash.AdminState -eq 'True'){'Red'} else {'Green'}) -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host ("Battery:",$ProfileHash.Battery,"%") -foregroundcolor $(if($ProfileHash.Battery -ge '77'){'Green'} elseif($ProfileHash.Battery -ge '33'){'Yellow'} else {'Red'}) -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host $ProfileHash.NetworkConnectivityWifi -foregroundcolor $(if($ProfileHash.NetworkConnectivityWifi[1]  -eq 'Connected'){'DarkCyan'} else {'Yellow'}) -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host "`r"
write-host ($ProfileHash.MeasureCommandMs,"ms") -foregroundcolor $(if($ProfileHash.MeasureCommandMs -le '999'){'Green'} elseif($ProfileHash.MeasureCommandMs -le '10000'){'Yellow'} else {'Red'}) -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host $(if(($ProfileHash.HistoryCommandLine).Length -ge 40) {($ProfileHash.HistoryCommandLine).substring(0,40)}else{$ProfileHash.HistoryCommandLine}) -foregroundcolor DarkGray -NoNewline
write-host '|'-foregroundcolor DarkCyan -NoNewline
write-host "`r"
write-host $ProfileHash.CurrentLocation -foregroundcolor Yellow -NoNewline
write-host $ProfileHash.ProfilePSFooter -foregroundcolor white -NoNewline
return " "
}

