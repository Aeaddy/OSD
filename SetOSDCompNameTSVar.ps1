$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment

$sn = gwmi win32_bios | select -Expand serialnumber | out-string

$TSEnv.Value("OSDComputerName") = "$($sn)"