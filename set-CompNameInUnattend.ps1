$COMPNAME=Get-WmiObject -Class Win32_BIOS | select -ExpandProperty serialnumber
$NEWCOMPNAME="C$COMPNAME"
(Get-Content c:\temp\unattend.xml).replace('@compname', $NEWCOMPNAME) | Set-Content c:\temp\unattend.xml

$ADUSER=Get-ADUser baxterjw | Select-Object -ExpandProperty DistinguishedName
$USEROU = ($ADUSER -split ',' | Select -Skip 2) -Join ',' #splits on , then skips the first 2 values of the split, then rejoins the array with a ,
$NEWOU = "OU=Computers,$USEROU" #adds OU=Computers
Write-Output $combined #outputs to pipeline
(Get-Content c:\temp\unattend.xml).replace('@domainou', $NEWCOMPNAME) | Set-Content c:\temp\unattend.xml