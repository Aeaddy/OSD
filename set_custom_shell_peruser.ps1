param($usertoset,$customshell)

#Script accepts command line parameters.
#$usertoset = "taskmanuser"
#$customshell = "C:\Windows\System32\taskmgr.EXE"


#Check to make sure that user is not logged on before attempting to load hive...ect.
#When time permits, we can probably log them off or put logic to access their currently loaded hive.

$usr = gwmi win32_computersystem | Select UserName

if (($usr.UserName) -like "*$usertoset*") {Write-Host "$usertoset is currently logged on. Exiting Script.";Exit 99}

#Return a list of profiles and check the profile paths for our username.
$profileList = dir 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' -Recurse

$profileList | ? {
	[string]$propath = $_.GetValue('ProfileImagePath')
	
	If ($propath -like "*$usertoset*")
		{
		Write-Host "Profile path: $propath"
		$rc = Test-Path -Path "$propath\ntuser.dat"
			if ($rc -eq $true)
				{
				Write-Host "NTUser.dat exists."
				reg load HKU\$usertoset $propath\ntuser.dat
				
				if ($LASTEXITCODE -eq 0)
					{
					Write-Host "Registry hive loaded successfully."
					#Key Reference: http://msdn.microsoft.com/en-us/library/ms838576(v=winembedded.5).aspx
					#Set Winlogon to look at user hive.
					reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot" /v Shell /d "USR:Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /f
					
					#Set user to load custom shell.
					reg add "HKU\$usertoset\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d $customshell /f
					
					#Unload user hive.
					reg unload HKU\$usertoset
					}
				else
					{
					Write-Host "Registry hive load failed Exiting script."
					Exit 0
					}
				}
		}
	}