$FILEPATH="C:\temp"
New-Item -ItemType Directory $FILEPATH

$ADID0 = "its\adam"
$ADID1 = [string][char[]][int[]]("80.97.115.115.119.111.114.100.49.50.51".Split(".")) -replace " "
$ADID2 = New-Object -TypeName System.Security.SecureString
$ADID1.ToCharArray() | ForEach-Object {$ADID2.AppendChar($_)}
$ADID3 = new-object -typename System.Management.Automation.PSCredential -argumentlist $ADID0, $ADID2

Configuration Test   
{ 
 
  param(
    [Parameter(Mandatory=$true)]
    [String[]]$Servers
  )
 
  Node $Servers
  { 


   
Group [string] #ResourceName
{
    GroupName = "Administrators"
    Credential = $ADID3
    Ensure = "Present"
    Members = "its\cris"

}




     }


  } 



#Commands to execute:
Test -Servers localhost -OutputPath $FILEPATH

Start-DscConfiguration -Path $FILEPATH -wait -Verbose -Force -ErrorAction Stop  

Remove-Item $FILEPATH -Recurse
