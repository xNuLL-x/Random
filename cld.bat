@Echo OFF
titlE Exec
SetLocal EnableDelayedExpansion
for /f %%a in ('prompt $E ^| cmd') do set "ESC=%%a"
set "CL=!ESC![1G!ESC![K"

cls
echO.
echO.

::Ping
:step
set "msg=%~1"
<nul set /p "= [/] !msg!"
ping -n 1 10.0.0.1 >nul 2>&1
<nul set /p "=!CL! [-] !msg!"
ping -n 1 10.0.0.1 >nul 2>&1
<nul set /p "=!CL! [-] !msg!"
ping -n 1 10.0.0.1 >nul 2>&1
echO.
goto :eof

::=========================================================
::Check Win Update::Mise à jour de Windows
::=========================================================
Set "_WInUpStatus=0"
sc query wuauserv | findstr /i "RUNNING" >nul 2>&1
if %errorlevel% equ 0 (
    set "_WInUpStatus=1"
    for /f "tokens=3" %%a in ('sc query wuauserv ^| findstr STATE') do set "_WInUpStatus=%%a"
) else (
    net start wuauserv >nul 2>&1
    timeout /t 2 /nobreak >nul
    sc query wuauserv | findstr /i "RUNNING" >nul 2>&1
    if !errorlevel! equ 0 set "_WInUpStatus=1"
)
exit /b %_WInUpStatus%
::Commandes NETSH
Set "WinDefender=0"
sc query windefend 2>nul | findstr /i "RUNNING" >nul 2>&1
if %errorlevel% equ 0 (
    set "WinDefender=1"
    set "FirewallDomain=0"
    set "FirewallPrivate=0"
    set "FirewallPublic=0"
    for /f "tokens=2" %%a in ('netsh advFirewall show DomainProfile state 2^>nul ^|
    findstr /i "state"') do 
        ecHO %%a | findstr /i "ON" >nul 2>&1 && set "FirewallDomain=1"
    
 for /f "tokens=2" %%a in ('netsh advFirewall show privateprofile state 2^>nul ^|
findstr /i "state"') do 
    echO %%a | findstr /i "ON" >nul 2>&1 && set "FirewallPrivate=1"

for /f "tokens=2" %%a in ('netsh advFirewall show publicprofile state 2^>nul ^|
findstr /i "state"') do
echO %%a | findstr /i "ON" >nul 2>&1 && set "FirewallPublic=1"
)