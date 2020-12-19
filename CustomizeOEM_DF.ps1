$ScriptPath = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$WINDIR=$env:WINDIR
$PROGRAMFILES=$env:ProgramW6432
$DATE=Get-Date -format M-d-yy

#copy-item -Force $ScriptPath\oemlogo.bmp "$WINDIR\system32\oemlogo.bmp"
#copy-item -Force $ScriptPath\Theme\* "$WINDIR\Resources\Themes"

#$ScreenSaver="$PROGRAMFILES\Meijer\Screensaver\1.0\01"
#if (!(Test-Path -path $ScreenSaver)){New-Item $ScreenSaver -Type Directory}
#copy-item -Force $ScriptPath\ScreenSaver\* $ScreenSaver

$MeijerStage="HKLM:\SOFTWARE\Meijer\Stage"
if (!(Test-Path -path $MeijerStage)){New-Item $MeijerStage}
New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer\Stage -Name Type -PropertyType String -Value "DF Client - DUS"
New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer\Stage -Name DATE -PropertyType String -Value $DATE

#Copy Tools (C:\Program Files (x86)\Meijer\Tools)

#Copy WinExit (C:\Windows\System32\)

#Copy ShellGo (C:\Windows\System32\)

#Copy idle (C:\Windows\System32\)

#Copy mlogo (C:\ProgramData\Microsoft\User Account Pictures\user.bmp)

#Delete Games (C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Games)

#Delete Printers (Windows\System32\Printing_Admin_Scripts\en-US ... cscript.exe prnmngr.vbs -xo)

#Create DFOff User
#strUser = "dfoff" 
#strPwd = "GLaDOS" 
#strDescription = "Support Account" 
#objUser.Put "PasswordExpired", 0 
#objPasswordNoChangeFlag = objUser.UserFlags XOR ADS_UF_PASSWD_CANT_CHANGE 
#objUser.Put "userFlags", objPasswordNoChangeFlag 
#objPasswordDontExpireFlag = objUser.UserFlags XOR ADS_UF_DONT_EXPIRE_PASSWD 
#objUser.Put "userFlags", objPasswordDontExpireFlag 
#Add to Adminstrators group

#Add DFUser
#strUser = "dfuser" 
#strPwd = "" 
#strDescription = "Primary User" 
#objUser.Put "PasswordExpired", 0 
#objPasswordNoChangeFlag = objUser.UserFlags XOR ADS_UF_PASSWD_CANT_CHANGE 
#objUser.Put "userFlags", objPasswordNoChangeFlag 
#objPasswordDontExpireFlag = objUser.UserFlags XOR ADS_UF_DONT_EXPIRE_PASSWD 
#objUser.Put "userFlags", objPasswordDontExpireFlag 
#Add to Users group.

#Create ImageMaint userNET USER imagemaint techsupportrecover
#WMIC USERACCOUNT WHERE "Name='imagemaint'" SET PasswordExpires=FALSE
#NET LOCALGROUP guests imagemaint /ADD
#NET LOCALGROUP administrators imagemaint /DELETE
#NET LOCALGROUP users imagemaint /DELETE

#Disable Guest User
#NET USER guest /active:NO4

#Setup Custom Shortcuts
#ProgDir = objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%")
#SysDir = objFSO.GetSpecialFolder(1) & "\"
#objShell.RegWrite "HKLM\Software\Meijer\ValidShortcuts","My Info.lnk,Logout - Citrix.lnk,Printers.lnk,Support Info.lnk","REG_SZ"
#objShell.RegWrite "HKLM\Software\Microsoft\Active Setup\Installed Components\{80CAA132-D03A-4B25-B2B2-B03089CD4B25}\","Setup Shortcuts","REG_SZ"
#objShell.RegWrite "HKLM\Software\Microsoft\Active Setup\Installed Components\{80CAA132-D03A-4B25-B2B2-B03089CD4B25}\StubPath",SysDir & "cscript.exe //B //T:60 """ & ProgDir & "\Meijer\Tools\SetShort.vbs""","REG_SZ"
#objShell.RegWrite "HKLM\Software\Microsoft\Active Setup\Installed Components\{80CAA132-D03A-4B25-B2B2-B03089CD4B25}\Version","1,0,0,0","REG_SZ"


##Set up first login
#REG ADD &quot;HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon&quot; /v DefaultUserName /d dfoff /f
#REG ADD &quot;HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon&quot; /v DefaultPassword /d GLaDOS /f
#REG ADD &quot;HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon&quot; /v AutoAdminLogon /d 1 /f

##Set up temp folder
#icacls c:\temp /grant Users:F /setintegritylevel H

#Configure KMS
#C:\Windows\System32\cscript.exe //b slmgr.vbs /skms w0982eusrs0080.us.meijer.com:1688<



