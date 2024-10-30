@echo off
:: Run the PowerShell script
powershell.exe -ExecutionPolicy Bypass -File "\\luc-fs02\UPD\RDPGuardian_UDP\rdpguardian_manual.ps1"

:: Wait for 60 seconds
timeout /t 60

:: Log off the user
logoff
