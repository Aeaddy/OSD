$ErrorActionPreference = "Stop"
$dism = $env:WINDIR + "\System32\dism.exe"
$BdeHdCFG = $env:WINDIR + "\System32\BdeHdCFG.exe"
$HPBiosConfig = ".\BiosConfigUtility.exe"
$BIOSPwd = "clientadmin"
$manageBDE = $env:WINDIR + "\System32\manage-bde.exe"
$colTPM = Get-WmiObject -class Win32_Tpm -namespace "root\CIMV2\Security\MicrosoftTpm"
$colVol = Get-WmiObject -namespace "root\CIMV2\Security\MicrosoftVolumeEncryption" -query "SELECT * from Win32_EncryptableVolume Where ProtectionStatus<>1" | Sort-Object -Property DriveLetter

Function Protect-BIOS() {    
    & $HPBiosConfig /nspwd:"$BIOSPwd" /verbose >> c:\temp\BiosConfig.log
}

Function Configure-BIOS() {
    Protect-BIOS

    & $HPBiosConfig /SetConfig:TPMConfig.REPSET /cspwd:"$BIOSPwd" /verbose >> c:\temp\BiosConfig.log
    & $HPBiosConfig /SetConfig:TPMConfig.REPSET /cspwd:"$BIOSPwd" /verbose >> c:\temp\BiosConfig.log
}

Function Test-RegistryValue {
    param(
        [Alias("PSPath")]
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Path
        ,
        [Parameter(Position = 1, Mandatory = $true)]
        [String]$Name
        ,
        [Switch]$PassThru
    ) 

    process {
        if (Test-Path $Path) {
            $Key = Get-Item -LiteralPath $Path
            if ($Key.GetValue($Name, $null) -ne $null) {
                if ($PassThru) {
                    Get-ItemProperty $Path $Name
                } else {
                    $true
                }
            } else {
                $false
            }
        } else {
            $false
        }
    }
}


#The first time we run this set the BIOS password.
If (-Not (Test-RegistryValue -Path HKLM:\SOFTWARE\Meijer -Name BitLocker)) {    

    Protect-BIOS
    New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "-1"
}

#If there is not TPM module present.
If (($colTPM.Length -eq 0) -or (-not ($colTPM))) {
   
    #Try enabling the TPM in the BIOS the first time we run this.
    $regBL =   Get-ItemProperty -Path HKLM:\SOFTWARE\Meijer -Name BitLocker  -ErrorAction Continue | Select-Object -ExpandProperty Bitlocker -ErrorAction Continue
    if (($regBL -eq -1) -or (-not $regBL)){
        Configure-BIOS
        New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "-2"
    }
    #Otherwsie we've already tried enabling the TPM in the BIOS then there's no TPM.
    else{
        #Mark this machine as NOT being Bitlockered.
        New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "0"
    }
    Exit
}

#If the bitlocker hard drive configuration tool doesn't exist, try installing the windows feature.
If (-Not (Test-Path $BdeHdCFG -PathType Leaf) ){
        & $dism /Online /Enable-Feature /FeatureName:BitLocker /NoRestart /Quiet
        New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "-3"
        Exit
}

#Configure the Hard Drive
& $BdeHdCFG -target default -quiet
#Success or Needs Reboot
if (($LASTEXITCODE -eq 0) -or ($LASTEXITCODE -eq -1063256058)) {
    New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "-4"
    Exit
    }
#Already configured    
ElseIf ($LASTEXITCODE = -1063256062) {


    foreach ($objTPM In $colTPM) {
        #If the TPM isn't enabled then enable it using the HP BIOS utility.
        If (-Not ($objTPM.IsEnabled_InitialValue)) {
            Configure-BIOS
            New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "-5"
            Exit
        }
        
        #If the TPM isn't owned then create a random password and use it to take ownership.
        If (-Not $objTPM.IsOwned_InitialValue) {
            $pass = Get-Random -Count 9 -InputObject (33..123) | % -begin {$aa=$null} -process {$aa += [char]$_} -end {$aa}
            & $manageBDE -tpm -o $pass
        }            
        
    
        #If there are no unprotected volumes mark the machine as being Bitlockered.
        If (($colVol.Length -eq 0) -or (-not ($colVol))) {        
            New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "1"
            Exit
        }

        #Enable Bitlocker on each unprotected volume.
        foreach ($objVol in $colVol){
            & $manageBDE -on $objVol.DriveLetter -rp -s
            
            #Automatically unlock drives so users doesn't have to authenticate to access them.
            If ($objVol.DriveLetter -ne "C:"){
                & $manageBDE -autounlock -enable $objVol.DriveLetter
            }
            if ($LASTEXITCODE -ne 0){            
                New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "-6"   
                Exit
            }
            
            #Mark this machine as being Bitlockered.
            New-ItemProperty -Force -Path HKLM:\SOFTWARE\Meijer -Name BitLocker -PropertyType String -Value "1"
            Exit
               
        }
    }            
}