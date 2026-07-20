@echo off
sfc /scannow
::Wait 1min before launching Dism.exe
timeout 60
cmd /c dism.exe /Online /Cleanup-image /Restorehealth