$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment

$OSDomJoinKey = [string][char[]][int[]]("82.97.105.110.121.68.97.121.115.50.55".Split(".")) -replace " "

$TSEnv.Value("OSDJoinPassword") = "$($OSDomJoinKey)"