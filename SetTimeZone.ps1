$ADID00 = "na\AltirisSUNA"
$ADID01 = [string][char[]][int[]]("68.73.66.97.81.114.61.71.51.108.99.100.74.37.79.87".Split(".")) -replace " "
$ADID02 = New-Object -TypeName System.Security.SecureString
$ADID01.ToCharArray() | ForEach-Object {$ADID02.AppendChar($_)}
$ADID03 = new-object -typename System.Management.Automation.PSCredential -argumentlist $ADID00, $ADID02
$Timezone = Get-WMIObject -class Win32_TimeZone -ComputerName ctit0s721 -Credential $ADID03
$TZSN=$Timezone.StandardName
(Get-Content x:\unattend.xml).replace('@TimeZone', $TZSN) | Set-Content X:\unattend.xml