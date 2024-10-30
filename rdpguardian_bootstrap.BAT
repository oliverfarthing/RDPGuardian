@echo off
set /a counter=0

:loop
powershell.exe -File "D:\UPD\RDPGuardian_UDP\rdpguardian_function.ps1"

:: Increment the counter
set /a counter+=1

:: Wait for 60 seconds
timeout /t 60 /nobreak

:: Check if the counter has reached 60
if %counter% geq 60 (
   echo Completed 60 iterations. Exiting...
   exit
)

:: Repeat the loop
goto loop
