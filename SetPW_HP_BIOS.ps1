Param(
    [Parameter(Mandatory=$True,Position=1)]
    [string]$BIOSPwd
)

#Set variables
$ScriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$HPQPswd="$ScriptPath\HPQPswd64.exe"
$pwdFile="$ScriptPath\pwd.bin"
$pwdArgs="/s /p""$BIOSPwd"" /f""$pwdFile"""
$HPBiosConfig = "$ScriptPath\BiosConfigUtility64.exe"
$HPBiosConfigOld = "$ScriptPath\BiosConfigUtility64Old.exe"

#Run the current version of BCU and determing if 
# unicode passwords are supported by the BIOS.
& $HPBiosConfig /unicode /verbose

#If the error code is 32 then unicode passwords are not supported
# so use the older version of the tool.  Otherwise, use the current version.
If ($LASTEXITCODE -eq 32) {
    & $HPBiosConfigOld /nspwd:"$BIOSPwd" /verbose
}
Else {
    #Create password file.
    Start-Process $HPQPswd $pwdArgs -wait

    #Set the password using the file
    If (Test-Path $pwdFile -PathType Leaf){ 
        Write-Host "Created password file:$pwdFile"
        & $HPBiosConfig /npwdfile:"$pwdFile" /verbose   
    }
    Else {
        Write-Host "Could not create password file:$pwdFile"
    }
}

