$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
#  Get the following information and plug it into the registry:
#    - Date
#    - Image Version
#    - Task Sequence Name

#  Get the date:

$WDATE = get-date -format d

#  Get the Image Version (already existing registry keys):

#$TSID = (get-itemproperty -path 'HKLM:\Software\Microsoft\Deployment 4\' -name 'Task Sequence ID').'Task Sequence ID'
#$TSNAME = (get-itemproperty -path 'HKLM:\Software\Microsoft\Deployment 4\' -name 'Task Sequence Name').'Task Sequence Name'
#$TSVER = (get-itemproperty -path 'HKLM:\Software\Microsoft\Deployment 4\' -name 'Task Sequence Version').'Task Sequence Version'
$TSNAME = $tsenv.Value("_SMSTSPackageName")
$TSID = $tsenv.Value("_SMSTSPackageID")


$TSVER = $tsenv.Value("OSDDataImageIndex")


#  Get rid of whitespace:

$WDATE = (write-output ($WDATE | out-string).trim()) 

#  Punch these into the registry

If(!(Test-Path HKLM:\Software\JamOn)){
    New-Item -Path HKLM:\Software\JamOn -Force
}

new-itemproperty -Path HKLM:\Software\JamOn -Name "Image Name" -PropertyType String -Value $TSNAME -force

new-itemproperty -Path HKLM:\Software\JamOn -Name "Image Date" -PropertyType String -Value $WDATE -force

new-itemproperty -Path HKLM:\Software\JamOn -Name "TS Package ID" -PropertyType String -Value $TSID -force

new-itemproperty -Path HKLM:\Software\JamOn -Name "Image Index" -PropertyType String -Value $TSVER -force

new-itemproperty -Path HKLM:\Software\JamOn -Name ImageVersion -PropertyType String -Value ("$TSNAME", "v$TSVER", "- $WDATE") -force


