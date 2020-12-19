$SYSDR = $env:SystemDrive
$FILEPATH="$SYSDR\temp"
New-Item -ItemType Directory $FILEPATH

Configuration ConfigWin10  
{ 
 
  param(
    [Parameter(Mandatory=$true)]
    [String[]]$Servers
  )
 
  Node $Servers
  { 
   

		
Registry TelemetryEnhanced
{
    Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    ValueName = "AllowTelemetry"
    Ensure = "Present"
    ValueData = "2"
    ValueType = "Dword"
}



Registry PartnerID
{
    Key = "HKLM:\SOFTWARE\Microsoft\Windows"
    ValueName = "DeployID"
    Ensure = "Present"
    ValueData = "1120586"
    ValueType = "string"
}

  } 
} 


#Commands to execute:
ConfigWin10 -Servers localhost -OutputPath $FILEPATH

Start-DscConfiguration -Path $FILEPATH -wait -Verbose -Force -ErrorAction Stop  

Remove-Item $FILEPATH -Recurse