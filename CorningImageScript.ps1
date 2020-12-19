###################################################################################
#Functions
###################################################################################

#Get domain controller from domain name

#MODIFY HERE
#!!!!!Edit the names of the domain controllers here if needed!!!!!
Function Convert-Domain {
Param ([String]$DOMCONT)
switch ($DOMCONT) 
    { 
        NA {"C1OC0DS21N.na"} 
        EMEA {"MBCI0DSS2001E.emea"} 
        AP {"SGCI0DSS2001A.ap"} 

        #default {"dc1"}
    }
}

###################################################################################

#Function - Determine and split Language details
Function Config-Language {
Param ([String]$LOCATION)

switch ($LOCATION) 
    { 

#MODIFY HERE
#!!!!!To add a new language, add the Name of the language here, and the appropriate locale details.!!!!!
#!!!!!You will also need to modify the form menu below to include the new language.!!!!!
    	Chinese-Simplified {"0804:00000804/zh-CN"}
        Chinese-Traditional {"0404:00000404/zh-TW"}
        English-UnitedStates {"0409:00000409/en-US"}
        English-UK {"0809:00000809/en-GB"}
        French {"040c:0000040c/fr-FR"}
        Danish {"0406:00000406/da-DK"}
        German-Standard {"0407:00000407/de-DE"}
        German-Swiss {"0807:00000807/de-DE"}
        German-Austrian {"0c07:00000407/de-DE"}
        Italian-Standard {"0410:00000410/it-IT"}
        Italian-Swiss {"0810:00000410/it-IT"}
        Japanese {"0411:e0010411/ja-JP"}
        Korea {"0412:e0010412/ko-KR"}
        Polish {"0415:00000415/pl-PL"}
        Russian {"0419:00000419/ru-RU"}
        Spanish-ModernSort {"0c0a:0000040a/es-ES"}
        Spanish-TraditionalSort {"040a:0000040a/es-ES"}
        Spanish-Mexican {"080a:0000080a/es-ES"}
        Spanish-Argentina {"2c0a:0000080a/es-ES"}
        Spanish-Guatemala {"100a:0000080a/es-ES"}
        Spanish-CostaRica {"140a:0000080a/es-ES"}
        Spanish-Panama {"180a:0000080a/es-ES"}
        Spanish-Venezuela {"200a:0000080a/es-ES"}
        Spanish-Colombia {"240a:0000080a/es-ES"}
        Turkish {"041f:0000041f/tr-TR"}

        #Default {"0409:00000409/en-US"}
    }
}

###################################################################################

#Function - Import Active Directory PowerShell module and connect to it
#!!!!!This section uses read only credentials to connect to Active Directory!!!!!
Function Connect-AD {
Param ([String]$ADDC)
import-module ActiveDirectory
$ADID0 = "na\deploydr"
$ADID1 = [string][char[]][int[]]("70.119.75.106.122.106.102.88.119.115.69.50.38.69.41.80".Split(".")) -replace " "
$ADID2 = New-Object -TypeName System.Security.SecureString
$ADID1.ToCharArray() | ForEach-Object {$ADID2.AppendChar($_)}
$ADID3 = new-object -typename System.Management.Automation.PSCredential -argumentlist $ADID0, $ADID2
new-psdrive -Name AD -PSProvider ActiveDirectory -Server $ADDC".corning.com" -Credential $ADID3 -Root "//RootDSE/" 
CD AD:
}

################################################################################### 


#Function - Split Domain\User
Function Split-User {
Param ([String]$NAME)
$NAME.split('\')
}

###################################################################################

#Function - Set Computername
Function Set-CompNameC {
Get-WmiObject -Class Win32_BIOS | select -ExpandProperty serialnumber
}

###################################################################################

#Function - Get AD User
Function Get-UserOU {
Param ([String]$ADUSERNAME)

Get-ADUser $ADUSERNAME | Select-Object -ExpandProperty DistinguishedName
}

###################################################################################

#Function - Split AD OU
Function Split-ADOU {
Param ([String]$ADUSERVAR)
($ADUSERVAR -split ',' | Select -Skip 2) -Join ',' #splits on , then skips the first 2 values of the split, then rejoins the array with a ,
}

#End Functions
###################################################################################

#Begin Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Corning New Computer Wizard"
$form.Size = New-Object System.Drawing.Size(450,350) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,230)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,230)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(370,20) 
$label.Text = "Please enter the domain\username"
$form.Controls.Add($label)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,40) 
$label.Size = New-Object System.Drawing.Size(310,20) 
$label.Text = "of the user that will own this device."
$form.Controls.Add($label)  

$textBox = New-Object System.Windows.Forms.TextBox 
$textBox.Location = New-Object System.Drawing.Point(10,70) 
$textBox.Size = New-Object System.Drawing.Size(260,20) 
$form.Controls.Add($textBox) 

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,120) 
$label.Size = New-Object System.Drawing.Size(220,20) 
$label.Text = "Please select a language:"
$form.Controls.Add($label) 

$listBox = New-Object System.Windows.Forms.ListBox 
$listBox.Location = New-Object System.Drawing.Point(10,140) 
$listBox.Size = New-Object System.Drawing.Size(260,20) 
$listBox.Height = 80

#MODIFY HERE
#!!!!!Add a new line here with the new name of the language to display in the drop-down menu!!!!!
#!!!!!This MUST match the language added above exactly!!!!!
[void] $ListBox.Items.Add("English-UnitedStates")
[void] $ListBox.Items.Add("Chinese-Simplified")
[void] $ListBox.Items.Add("Chinese-Traditional")
[void] $ListBox.Items.Add("English-UK")
[void] $ListBox.Items.Add("French")
[void] $ListBox.Items.Add("Danish")
[void] $ListBox.Items.Add("German-Standard")
[void] $ListBox.Items.Add("German-Swiss")
[void] $ListBox.Items.Add("German-Austrian")
[void] $ListBox.Items.Add("Italian-Standard")
[void] $ListBox.Items.Add("Italian-Swiss")
[void] $ListBox.Items.Add("Japanese")
[void] $ListBox.Items.Add("Korean")
[void] $ListBox.Items.Add("Polish")
[void] $ListBox.Items.Add("Russian")
[void] $ListBox.Items.Add("Spanish-ModernSort")
[void] $ListBox.Items.Add("Spanish-Mexican")
[void] $ListBox.Items.Add("Spanish-TraditionalSort")
[void] $ListBox.Items.Add("Spanish-Argentina")
[void] $ListBox.Items.Add("Spanish-Guatemala")
[void] $ListBox.Items.Add("Spanish-CostaRica")
[void] $ListBox.Items.Add("Spanish-Panama")
[void] $ListBox.Items.Add("Spanish-Venezuela")
[void] $ListBox.Items.Add("Spanish-Columbia")
[void] $ListBox.Items.Add("Turkish")

$form.Controls.Add($listBox) 

$form.Topmost = $True

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
#END FORM


#If OK Button was pressed, run this code block
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{

#Check for User name input, if not assume only domain and apply generic user and OU details
$CHECKUSER = $textBox.Text
IF ($CHECKUSER -like '*\*') {

#Split Domain\User
$ADRESULT=Split-User $TextBox.Text
$ADDOMAIN=$ADRESULT[0]
$USERNAME=$ADRESULT[1]

#Set-FQDN
$ADFQDN="$ADDOMAIN.corning.com"

#Get domain controller from domain name
$ADSERVER = Convert-Domain $ADDOMAIN

#Determine and split Language details
$LANGUAGE=Config-Language $ListBox.SelectedItem
$LOCALID=$LANGUAGE.split('/')[0]
$LANGUAGEID=$LANGUAGE.split('/')[1]
$LOCATION1=$ListBox.SelectedItem

#Import Active Directory PowerShell module and connect to it
Connect-AD $ADSERVER

#Set Computername to C+Serial number and trim to 15 characters
$COMPNAME=Set-CompNameC
$NEWCOMPNAME="C$COMPNAME"
$TRIMCOMPNAME=$NEWCOMPNAME.Substring(0,15)

#Get User OU
$ERROR.Clear()
$ADUSER=Get-UserOU $USERNAME

#If User does not exist, display error message
IF ($ERROR.Count -gt 0){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#Error Message Form
$form = New-Object System.Windows.Forms.Form 
$form.Text = "Error!"
$form.Size = New-Object System.Drawing.Size(350,150) 
$form.StartPosition = "CenterScreen"

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(130,70)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Close"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(350,20) 
$label.Text = "This user was not found. Please shut down and try again."
$form.Controls.Add($label)

$result = $form.ShowDialog()
exit
}
#End Form

#Split AD OU and define Computer OU
$USEROU=Split-ADOU $ADUSER
$NEWOU = "OU=Computers,$USEROU" 

$ADDJPW = [string][char[]][int[]]("69.67.74.57.121.57.101.94.118.42.68.71.94.68.40.111".Split(".")) -replace " "

#Write-Output to unattend.xml
#cd X:
(Get-Content x:\unattend.xml).replace('@CompName', $TRIMCOMPNAME) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@domainou', $NEWOU) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@userName', $USERNAME) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@LocalID', $LOCALID) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@LanguageID', $LANGUAGEID) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@domain', $ADFQDN) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@domainpw', $ADDJPW) | Set-Content X:\unattend.xml



#writing output for Altiris
Write-host $ADSERVER
Write-host $LOCATION1
Write-host $LANGUAGE
Write-host $LANGUAGEID
Write-host $LOCALID
Write-Host $USERNAME
Write-Host $NEWOU
Write-Host $ADFQDN

}ELSE{

#Script block for Generic  build
Write-Host "Generic"
#Set username variable
$USERNAME="Corning"
#Set domain name
$ADDOMAIN=$TextBox.Text

#Set-FQDN
$ADFQDN="$ADDOMAIN.corning.com"

#Get domain controller from domain name
$ADSERVER = Convert-Domain $ADDOMAIN

#Determine and split Language details
$LANGUAGE=Config-Language $ListBox.SelectedItem
$LOCALID=$LANGUAGE.split('/')[0]
$LANGUAGEID=$LANGUAGE.split('/')[1]
$LOCATION1=$ListBox.SelectedItem

#Set Computername to C+Serial number and trim to 15 characters
$COMPNAME=Set-CompNameC
$NEWCOMPNAME="C$COMPNAME"
$TRIMCOMPNAME=$NEWCOMPNAME.Substring(0,15)

#Set Staging OU
$NEWOU="OU=Computers,OU=Staging,OU=IT-SD,DC=$ADDOMAIN,DC=corning,DC=com"

$ADDJPW = [string][char[]][int[]]("69.67.74.57.121.57.101.94.118.42.68.71.94.68.40.111".Split(".")) -replace " "

#Write-Output to unattend.xml
#cd X:
(Get-Content x:\unattend.xml).replace('@CompName', $TRIMCOMPNAME) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@domainou', $NEWOU) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@userName', $USERNAME) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@LocalID', $LOCALID) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@LanguageID', $LANGUAGEID) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@domain', $ADFQDN) | Set-Content X:\unattend.xml
(Get-Content x:\unattend.xml).replace('@domainpw', $ADDJPW) | Set-Content X:\unattend.xml

#writing output for Altiris
Write-host $ADSERVER
Write-host $LOCATION1
Write-host $LANGUAGE
Write-host $LANGUAGEID
Write-host $LOCALID
Write-Host $USERNAME
Write-Host $NEWOU
Write-Host $ADFQDN

}

}

