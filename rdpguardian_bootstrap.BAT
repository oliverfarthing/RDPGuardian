@echo off

:loop
powershell.exe -File "D:\UPD\RDPGuardian_UDP\rdpguardian_function.ps1"

:: Wait for 60 seconds
timeout /t 60 /nobreak

:: Repeat the loop
goto loop
