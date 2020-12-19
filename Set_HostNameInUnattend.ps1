$COMPNAME=Get-WmiObject -Class Win32_BIOS | select -ExpandProperty serialnumber
$NEWCOMPNAME="C$COMPNAME"
(Get-Content c:\temp\unattend.xml).replace('@compname', $NEWCOMPNAME) | Set-Content c:\temp\unattend.xml