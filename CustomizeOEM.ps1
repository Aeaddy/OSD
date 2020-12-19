$ScriptPath = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$WINDIR=$env:WINDIR
$PROGRAMFILES=$env:ProgramW6432
$DATE=Get-Date -format M-d-yy

copy-item -Force $ScriptPath\oemlogo.bmp "$WINDIR\system32\oemlogo.bmp"
copy-item -Force $ScriptPath\logo.bmp "$WINDIR\logo.bmp"
copy-item -Force $ScriptPath\Theme\* "$WINDIR\Resources\Themes"

$ScreenSaver="$PROGRAMFILES\Meijer\Screensaver\1.0\01"
if (!(Test-Path -path $ScreenSaver)){New-Item $ScreenSaver -Type Directory}
copy-item -Force $ScriptPath\ScreenSaver\* $ScreenSaver

$MeijerStage="HKLM:\SOFTWARE\Meijer\Stage"
if (!(Test-Path -path $MeijerStage)){New-Item -Force $MeijerStage}
New-ItemProperty -Force -Path $MeijerStage -Name Type -PropertyType String -Value "Full Client - IUS"
New-ItemProperty -Force -Path $MeijerStage -Name DATE -PropertyType String -Value $DATE