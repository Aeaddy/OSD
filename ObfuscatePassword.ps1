Param([Parameter(Mandatory=$true)][string]$password)
$var0=[int[]][char[]]$password
$var1=[int[]][char[]]$var0 -join "."
cls
Write-Host The output below can be used in a script in place of a password:
write-host [string][char[]][int[]]'("'$var1'".Split(".")) -replace " "'
