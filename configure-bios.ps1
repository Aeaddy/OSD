Param(
    [Parameter(Mandatory=$True,Position=1)]
    [string]$BIOSPwd
)

#Set global values.
$ErrorActionPreference = "Stop"
$ScriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$colTPM = Get-WmiObject -class Win32_Tpm -namespace "root\CIMV2\Security\MicrosoftTpm"
$manufacturer=(Get-WmiObject Win32_ComputerSystem).Manufacturer
$manufacturerPath="$ScriptPath\$manufacturer"
$global:TSEnv = New-Object -COMObject Microsoft.SMS.TSEnvironment

#If the Manufacturer's folder has a protection script then run it.
Function Protect-BIOS() {
    $protectBiosPath = $manufacturerPath + "\protect-bios.ps1"
    Write-Host "Protect $manufacturer BIOS: " $protectBiosPath
    If (Test-Path $protectBiosPath -PathType Leaf){        
        & $protectBiosPath $BIOSPwd
    }
    Else {
        Write-Host "No protection script for $manufacturer"
    }        
}

#If the Manufacturer's folder has a configuration script then run it.
Function Configure-BIOS() {    
   
   $configureBiosPath = $manufacturerPath + "\configure-bios.ps1"
    Write-Host "Configure $manufacturer BIOS: " $configureBiosPath
    If (Test-Path $configureBiosPath -PathType Leaf){
        & $configureBiosPath $BIOSPwd
    }
    Else {
        Write-Host "No configuration script for $manufacturer"
    }        
}


###MAIN ROUTINE###
#Verify that the manufacturer folder exists.
If (-Not (Test-Path $manufacturerPath -PathType Container)) {
    Write-Host "No manufacturer folder found for $manufacturer"
    Exit
}


#Protect the BIOS.
Protect-BIOS

#If there is no TPM present.
If (($colTPM.Length -eq 0) -or (-not ($colTPM))) {
   
    #Configure the BIOS
    Configure-BIOS

    #If we have a Task Sequence object set the varible.  Otherwise exit with error code.
    If ($global:TSEnv){
        $global:TSEnv.Value("TPMNeedsReboot") = $True
        Exit
    }
    Else {
        Exit 3010
    }
} 
Else {

    #If the TPM exists but isn't enabled then configure the BIOS
    foreach ($objTPM In $colTPM) {        
        If (-Not ($objTPM.IsEnabled_InitialValue)) {
            Configure-BIOS
            
            #If we have a Task Sequence object set the varible.  Otherwise exit with error code.
            If ($global:TSEnv){
                $global:TSEnv.Value("TPM_Enabled") = $True
                Exit
            }
            Else {
                Exit 3010
            }
        }                   
    }
}
Exit