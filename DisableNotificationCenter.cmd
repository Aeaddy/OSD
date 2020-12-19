reg load HKU\defuser c:\users\default\ntuser.dat
reg add "HKU\defuser\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f

reg unload HKU\defuser