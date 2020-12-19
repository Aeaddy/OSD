$TSEnv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$mjr_environment=$TSEnv.Value("mjr_environment")

Function Load-Form 
{
    $Form.Controls.Add($TBUserName)
    $Form.Controls.Add($GBUserName)
    $Form.Controls.Add($ButtonOK)
    $Form.Add_Shown({$Form.Activate()})
    [void] $Form.ShowDialog()
}
 
Function Set-OSDPrimaryUser 
{
    $ErrorProvider.Clear()
    if ($TBUserName.Text.Length -eq 0) 
    {
        $ErrorProvider.SetError($GBUserName, "Please enter a primary user name.")
    }

    elseif ($TBUserName.Text.Length -gt 15) 
    {
        $ErrorProvider.SetError($GBUserName, "User name cannot be more than 15 characters.")
    }

    #Validation Rule for user names.
    elseif ($TBUserName.Text -match "^[-_]|[^a-zA-Z0-9-_]")
    {
        $ErrorProvider.SetError($GBUserName, "User name invalid, please correct the user name.")
    }

    else 
    {
        $OSDPrimaryUser = "$mjr_environment\$($TBUserName)"
        $TSEnv.Value("SMSTSUdaUsers") = "$($OSDPrimaryUser)"
        $Form.Close()
    }
}
 
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 
$Global:ErrorProvider = New-Object System.Windows.Forms.ErrorProvider
 
$Form = New-Object System.Windows.Forms.Form    
$Form.Size = New-Object System.Drawing.Size(285,140)  
$Form.MinimumSize = New-Object System.Drawing.Size(285,140)
$Form.MaximumSize = New-Object System.Drawing.Size(285,140)
$Form.StartPosition = "CenterScreen"
$Form.SizeGripStyle = "Hide"
$Form.Text = "Enter Employee ID ($mjr_environment)"
$Form.ControlBox = $false
$Form.TopMost = $true
 
$TBUserName = New-Object System.Windows.Forms.TextBox
$TBUserName.Location = New-Object System.Drawing.Size(25,30)
$TBUserName.Size = New-Object System.Drawing.Size(215,50)
$TBUserName.TabIndex = "1"
 
$GBUserName = New-Object System.Windows.Forms.GroupBox
$GBUserName.Location = New-Object System.Drawing.Size(20,10)
$GBUserName.Size = New-Object System.Drawing.Size(225,50)
$GBUserName.Text = "User name:"
 
$ButtonOK = New-Object System.Windows.Forms.Button
$ButtonOK.Location = New-Object System.Drawing.Size(195,70)
$ButtonOK.Size = New-Object System.Drawing.Size(50,20)
$ButtonOK.Text = "OK"
$ButtonOK.TabIndex = "2"
$ButtonOK.Add_Click({Set-OSDPrimaryUser})

$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Set-OSDPrimaryUser}})

Load-Form