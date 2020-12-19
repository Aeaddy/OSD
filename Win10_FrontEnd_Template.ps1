
Function Update-MDT {
#!!!!!To add a new server, add the Name of the language here, and the appropriate server details.!!!!!
#!!!!!You will also need to modify the form menu below to include the new server!!!!!
Function Config-Server {
Param ([String]$MDTSERVER)

switch ($MDTSERVER) 
    { 

        nahollap716{"nahollap716"}
        naaguecm06{"naaguecm06"}
        naatlacm06{"naatlacm06"}
        nabadmcm06{"nabadmcm06"}
        nabangcm06{"nabangcm06"}
        nabarccm06{"nabarccm06"}
        nabigrcm06{"nabigrcm06"}
        nabostcm06{"nabostcm06"}
        nabriscm06{"nabriscm06"}
        nabruccm06{"nabruccm06"}
        nabudacm06{"nabudacm06"}
        NACALACM06{"nacalacm06"}
        nacalgcm06{"nacalgcm06"}
        nacheacm06{"nacheacm06"}
        nachencm06{"nachencm06"}
        nachiccm06{"nachiccm06"}
        naconocm06{"naconocm06"}
        nadallcm06{"nadallcm06"}
        nadelhcm06{"nadelhcm06"}
        nadenvcm06{"nadenvcm06"}
        nadubacm06{"nadubacm06"}
        nadublcm06{"nadublcm06"}
        nahighcm06{"nahighcm06"}
        naholacm06{"naholacm06"}
        nahollcm06{"nahollcm06"}
        nahollcm07{"nahollcm07"}
        nahollcm08{"nahollcm08"}
        nahongcm06{"nahongcm06"}
        nahouscm06{"nahouscm06"}
        nahydecm06{"nahydecm06"}
        nakualcm06{"nakualcm06"}
        nalondcm06{"nalondcm06"}
        nalosacm06{"nalosacm06"}
        naludicm06{"naludicm06"}
        nalyoncm06{"nalyoncm06"}
        namadrcm06{"namadrcm06"}
        namelbcm06{"namelbcm06"}
        namenzcm06{"namenzcm06"}
        namumbcm06{"namumbcm06"}
        nanewycm06{"nanewycm06"}
        naparicm06{"naparicm06"}
        naphilcm06{"naphilcm06"}
        napudocm06{"napudocm06"}
        napuxicm06{"napuxicm06"}
        naquarcm06{"naquarcm06"}
        naquelcm06{"naquelcm06"}
        nasanfcm06{"nasanfcm06"}
        naseatcm06{"naseatcm06"}
        nasingcm06{"nasingcm06"}
        nasthicm06{"nasthicm06"}
        nasydncm06{"nasydncm06"}
        natorocm06{"natorocm06"}
        nawashcm06{"nawashcm06"}
        
      Default {"nahollap716"}
    }
}

#Begin Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Windows 10 Upgrade Wizard"
$form.Size = New-Object System.Drawing.Size(600,350) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(200,250)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(290,250)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton

# Create a group that will contain your radio buttons
    $MyGroupBox = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox.Location = '290,40'
    $MyGroupBox.size = '180,180'
    $MyGroupBox.text = "Configure Bitlocker Encryption"
    
    # Create the collection of radio buttons
    $RadioButton1 = New-Object System.Windows.Forms.RadioButton
    $RadioButton1.Location = '20,80'
    $RadioButton1.size = '90,20'
    $RadioButton1.Checked = $false 
    $RadioButton1.Text = "Yes"
 
    $RadioButton2 = New-Object System.Windows.Forms.RadioButton
    $RadioButton2.Location = '20,110'
    $RadioButton2.size = '90,20'
    $RadioButton2.Checked = $true
    $RadioButton2.Text = "No"
 
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(420,20) 
$label.Text = "Please select a location (Server):"

$listBox = New-Object System.Windows.Forms.ListBox 
$listBox.Location = New-Object System.Drawing.Point(10,40) 
$listBox.Size = New-Object System.Drawing.Size(260,20) 
$listBox.Height = 180
   # Set the font of the text to be used within the form
    $Font = New-Object System.Drawing.Font("Times New Roman",15)
    $listbox.Font = $Font

#!!!!!Add a new line here with the new name of the language to display in the drop-down menu!!!!!
#!!!!!This MUST match the language added above exactly!!!!!
[void] $ListBox.Items.Add("nahollap716")
[void] $ListBox.Items.Add("naaguecm06")
[void] $ListBox.Items.Add("naatlacm06")
[void] $ListBox.Items.Add("nabadmcm06")
[void] $ListBox.Items.Add("nabangcm06")
[void] $ListBox.Items.Add("nabarccm06")
[void] $ListBox.Items.Add("nabigrcm06")
[void] $ListBox.Items.Add("nabostcm06")
[void] $ListBox.Items.Add("nabriscm06")
[void] $ListBox.Items.Add("nabruccm06")
[void] $ListBox.Items.Add("nabudacm06")
[void] $ListBox.Items.Add("nacalacm06")
[void] $ListBox.Items.Add("nacalgcm06")
[void] $ListBox.Items.Add("nacheacm06")
[void] $ListBox.Items.Add("nachencm06")
[void] $ListBox.Items.Add("nachiccm06")
[void] $ListBox.Items.Add("naconocm06")
[void] $ListBox.Items.Add("nadallcm06")
[void] $ListBox.Items.Add("nadelhcm06")
[void] $ListBox.Items.Add("nadenvcm06")
[void] $ListBox.Items.Add("nadubacm06")
[void] $ListBox.Items.Add("nadublcm06")
[void] $ListBox.Items.Add("nahighcm06")
[void] $ListBox.Items.Add("naholacm06")
[void] $ListBox.Items.Add("nahollcm06")
[void] $ListBox.Items.Add("nahollcm07")
[void] $ListBox.Items.Add("nahollcm08")
[void] $ListBox.Items.Add("nahongcm06")
[void] $ListBox.Items.Add("nahouscm06")
[void] $ListBox.Items.Add("nahydecm06")
[void] $ListBox.Items.Add("nakualcm06")
[void] $ListBox.Items.Add("nalondcm06")
[void] $ListBox.Items.Add("nalosacm06")
[void] $ListBox.Items.Add("naludicm06")
[void] $ListBox.Items.Add("nalyoncm06")
[void] $ListBox.Items.Add("namadrcm06")
[void] $ListBox.Items.Add("namelbcm06")
[void] $ListBox.Items.Add("namenzcm06")
[void] $ListBox.Items.Add("namumbcm06")
[void] $ListBox.Items.Add("nanewycm06")
[void] $ListBox.Items.Add("naparicm06")
[void] $ListBox.Items.Add("naphilcm06")
[void] $ListBox.Items.Add("napudocm06")
[void] $ListBox.Items.Add("napuxicm06")
[void] $ListBox.Items.Add("naquarcm06")
[void] $ListBox.Items.Add("naquelcm06")
[void] $ListBox.Items.Add("nasanfcm06")
[void] $ListBox.Items.Add("naseatcm06")
[void] $ListBox.Items.Add("nasingcm06")
[void] $ListBox.Items.Add("nasthicm06")
[void] $ListBox.Items.Add("nasydncm06")
[void] $ListBox.Items.Add("natorocm06")
[void] $ListBox.Items.Add("nawashcm06")

$listBox.SetSelected(0,$true)

    $form.Controls.AddRange(@($MyGroupBox,$listBox,$OKButton,$CancelButton,$label))
    $MyGroupBox.Controls.AddRange(@($Radiobutton1,$RadioButton2))
    $form.Add_Shown({$form.Activate()})   
$result = $form.ShowDialog()
#END FORM

#If OK Button was pressed, run this code block
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{

$USERPW = [string][char[]][int[]]("72.101.108.108.111.50.121.111.117".Split(".")) -replace " "
$SELECTEDMDTSERVER = $ListBox.SelectedItem;

        # Check the current state of each radio button and respond accordingly
        if ($RadioButton1.Checked){ $BLENABLED = "NO" }
        elseif ($RadioButton2.Checked){ $BLENABLED = "YES" };

[System.Windows.Forms.MessageBox]::Show("cscript \\$SELECTEDMDTSERVER\deploymentshare$\scripts\litetouch.vbs /TaskSequenceID:WIN10UPGRADE /SkipTaskSequence:YES /SkipBitLocker:$BLENABLED /SkipSummary:YES /UserID:vae7 /UserDomain:NA /UserPassword:$USERPW" , "RunLine")
#cscript \\$SELECTEDMDTSERVER\deploymentshare$\scripts\litetouch.vbs /TaskSequenceID:WIN10UPGRADE /SkipTaskSequence:YES /SkipBitLocker:$BLENABLED /SkipSummary:YES /UserID:vae7 /UserDomain:NA /UserPassword:$USERPW

}

}


Function Install-MDT {
#!!!!!To add a new server, add the Name of the language here, and the appropriate server details.!!!!!
#!!!!!You will also need to modify the form menu below to include the new server!!!!!
Function Config-Server {
Param ([String]$MDTSERVER)

switch ($MDTSERVER) 
    { 

        nahollap716{"nahollap716"}
        naaguecm06{"naaguecm06"}
        naatlacm06{"naatlacm06"}
        nabadmcm06{"nabadmcm06"}
        nabangcm06{"nabangcm06"}
        nabarccm06{"nabarccm06"}
        nabigrcm06{"nabigrcm06"}
        nabostcm06{"nabostcm06"}
        nabriscm06{"nabriscm06"}
        nabruccm06{"nabruccm06"}
        nabudacm06{"nabudacm06"}
        NACALACM06{"nacalacm06"}
        nacalgcm06{"nacalgcm06"}
        nacheacm06{"nacheacm06"}
        nachencm06{"nachencm06"}
        nachiccm06{"nachiccm06"}
        naconocm06{"naconocm06"}
        nadallcm06{"nadallcm06"}
        nadelhcm06{"nadelhcm06"}
        nadenvcm06{"nadenvcm06"}
        nadubacm06{"nadubacm06"}
        nadublcm06{"nadublcm06"}
        nahighcm06{"nahighcm06"}
        naholacm06{"naholacm06"}
        nahollcm06{"nahollcm06"}
        nahollcm07{"nahollcm07"}
        nahollcm08{"nahollcm08"}
        nahongcm06{"nahongcm06"}
        nahouscm06{"nahouscm06"}
        nahydecm06{"nahydecm06"}
        nakualcm06{"nakualcm06"}
        nalondcm06{"nalondcm06"}
        nalosacm06{"nalosacm06"}
        naludicm06{"naludicm06"}
        nalyoncm06{"nalyoncm06"}
        namadrcm06{"namadrcm06"}
        namelbcm06{"namelbcm06"}
        namenzcm06{"namenzcm06"}
        namumbcm06{"namumbcm06"}
        nanewycm06{"nanewycm06"}
        naparicm06{"naparicm06"}
        naphilcm06{"naphilcm06"}
        napudocm06{"napudocm06"}
        napuxicm06{"napuxicm06"}
        naquarcm06{"naquarcm06"}
        naquelcm06{"naquelcm06"}
        nasanfcm06{"nasanfcm06"}
        naseatcm06{"naseatcm06"}
        nasingcm06{"nasingcm06"}
        nasthicm06{"nasthicm06"}
        nasydncm06{"nasydncm06"}
        natorocm06{"natorocm06"}
        nawashcm06{"nawashcm06"} 
        Default {"nahollap716"}
    }
}

#Begin Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Windows 10 Deployment Wizard"
$form.Size = New-Object System.Drawing.Size(600,350) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(200,250)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(290,250)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton

# Create a group that will contain your radio buttons
    $MyGroupBox = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox.Location = '290,40'
    $MyGroupBox.size = '120,180'
    $MyGroupBox.text = "Configure User Data Backup"
    
    # Create the collection of radio buttons
    $RadioButton1 = New-Object System.Windows.Forms.RadioButton
    $RadioButton1.Location = '5,80'
    $RadioButton1.size = '100,20'
    $RadioButton1.Checked = $false 
    $RadioButton1.Text = "Yes"
 
    $RadioButton2 = New-Object System.Windows.Forms.RadioButton
    $RadioButton2.Location = '5,110'
    $RadioButton2.size = '100,20'
    $RadioButton2.Checked = $true
    $RadioButton2.Text = "No"

# Create a group that will contain your radio buttons
    $MyGroupBox2 = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox2.Location = '430,40'
    $MyGroupBox2.size = '120,180'
    $MyGroupBox2.text = "Rename Computer"
    
    # Create the collection of radio buttons
    $RadioButton3 = New-Object System.Windows.Forms.RadioButton
    $RadioButton3.Location = '5,80'
    $RadioButton3.size = '100,20'
    $RadioButton3.Checked = $false 
    $RadioButton3.Text = "Yes"
 
    $RadioButton4 = New-Object System.Windows.Forms.RadioButton
    $RadioButton4.Location = '5,110'
    $RadioButton4.size = '100,20'
    $RadioButton4.Checked = $true
    $RadioButton4.Text = "No"
 
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(420,20) 
$label.Text = "Please select a location (Server):"

$listBox = New-Object System.Windows.Forms.ListBox 
$listBox.Location = New-Object System.Drawing.Point(10,40) 
$listBox.Size = New-Object System.Drawing.Size(260,20) 
$listBox.Height = 180
   # Set the font of the text to be used within the form
    $Font = New-Object System.Drawing.Font("Times New Roman",15)
    $listbox.Font = $Font

#!!!!!Add a new line here with the new name of the language to display in the drop-down menu!!!!!
#!!!!!This MUST match the language added above exactly!!!!!
[void] $ListBox.Items.Add("nahollap716")
[void] $ListBox.Items.Add("naaguecm06")
[void] $ListBox.Items.Add("naatlacm06")
[void] $ListBox.Items.Add("nabadmcm06")
[void] $ListBox.Items.Add("nabangcm06")
[void] $ListBox.Items.Add("nabarccm06")
[void] $ListBox.Items.Add("nabigrcm06")
[void] $ListBox.Items.Add("nabostcm06")
[void] $ListBox.Items.Add("nabriscm06")
[void] $ListBox.Items.Add("nabruccm06")
[void] $ListBox.Items.Add("nabudacm06")
[void] $ListBox.Items.Add("nacalacm06")
[void] $ListBox.Items.Add("nacalgcm06")
[void] $ListBox.Items.Add("nacheacm06")
[void] $ListBox.Items.Add("nachencm06")
[void] $ListBox.Items.Add("nachiccm06")
[void] $ListBox.Items.Add("naconocm06")
[void] $ListBox.Items.Add("nadallcm06")
[void] $ListBox.Items.Add("nadelhcm06")
[void] $ListBox.Items.Add("nadenvcm06")
[void] $ListBox.Items.Add("nadubacm06")
[void] $ListBox.Items.Add("nadublcm06")
[void] $ListBox.Items.Add("nahighcm06")
[void] $ListBox.Items.Add("naholacm06")
[void] $ListBox.Items.Add("nahollcm06")
[void] $ListBox.Items.Add("nahollcm07")
[void] $ListBox.Items.Add("nahollcm08")
[void] $ListBox.Items.Add("nahongcm06")
[void] $ListBox.Items.Add("nahouscm06")
[void] $ListBox.Items.Add("nahydecm06")
[void] $ListBox.Items.Add("nakualcm06")
[void] $ListBox.Items.Add("nalondcm06")
[void] $ListBox.Items.Add("nalosacm06")
[void] $ListBox.Items.Add("naludicm06")
[void] $ListBox.Items.Add("nalyoncm06")
[void] $ListBox.Items.Add("namadrcm06")
[void] $ListBox.Items.Add("namelbcm06")
[void] $ListBox.Items.Add("namenzcm06")
[void] $ListBox.Items.Add("namumbcm06")
[void] $ListBox.Items.Add("nanewycm06")
[void] $ListBox.Items.Add("naparicm06")
[void] $ListBox.Items.Add("naphilcm06")
[void] $ListBox.Items.Add("napudocm06")
[void] $ListBox.Items.Add("napuxicm06")
[void] $ListBox.Items.Add("naquarcm06")
[void] $ListBox.Items.Add("naquelcm06")
[void] $ListBox.Items.Add("nasanfcm06")
[void] $ListBox.Items.Add("naseatcm06")
[void] $ListBox.Items.Add("nasingcm06")
[void] $ListBox.Items.Add("nasthicm06")
[void] $ListBox.Items.Add("nasydncm06")
[void] $ListBox.Items.Add("natorocm06")
[void] $ListBox.Items.Add("nawashcm06")

$listBox.SetSelected(0,$true)
    $form.Controls.AddRange(@($MyGroupBox,$listBox,$MyGroupBox2,$OKButton,$CancelButton,$label))
    $MyGroupBox.Controls.AddRange(@($Radiobutton1,$RadioButton2))
    $MyGroupBox2.Controls.AddRange(@($RadioButton3,$RadioButton4))
    $form.Add_Shown({$form.Activate()})   
$result = $form.ShowDialog()
#END FORM

#If OK Button was pressed, run this code block
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{

$USERPW = [string][char[]][int[]]("72.101.108.108.111.50.121.111.117".Split(".")) -replace " "
$SELECTEDMDTSERVER = $ListBox.SelectedItem;

        # Check the current state of each radio button and respond accordingly
        if ($RadioButton1.Checked){ $UDENABLED = "NO" }
        elseif ($RadioButton2.Checked){ $UDENABLED = "YES" };

        # Check the current state of each radio button and respond accordingly
        if ($RadioButton3.Checked){ $CNENABLED = "NO" }
        elseif ($RadioButton4.Checked){ $CNENABLED = "YES" };

#[System.Windows.Forms.MessageBox]::Show("cscript \\$SELECTEDMDTSERVER\deploymentshare$\scripts\litetouch.vbs /TaskSequenceID:WIN10DEPLOY /SkipTaskSequence:YES /SkipUserData:$UDENABLED /SkipComputerName:$CNENABLED /SkipSummary:YES /UserID:vae7 /UserDomain:NA /UserPassword:$USERPW" , "RunLine")
cscript \\$SELECTEDMDTSERVER\deploymentshare$\scripts\litetouch.vbs /TaskSequenceID:WIN10DEPLOY /SkipTaskSequence:YES /SkipUserData:$UDENABLED /SkipComputerName:$CNENABLED /SkipSummary:YES /UserID:vae7 /UserDomain:NA /UserPassword:$USERPW

}

}

#Begin Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Windows 10 Deployment Wizard"
$form.Size = New-Object System.Drawing.Size(580,350) 
$form.StartPosition = "CenterScreen"
$form.BackColor = "#26619C"

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(75,35) 
$label.Size = New-Object System.Drawing.Size(450,50) 
$label.Text = "Haworth Windows 10 Deployment"
$label.Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Italic)
$label.ForeColor = "white"
$form.Controls.Add($label)

$UGButton = New-Object System.Windows.Forms.Button
$UGButton.Location = New-Object System.Drawing.Point(50,100)
$UGButton.Size = New-Object System.Drawing.Size(200,150)
$UGButton.Text = "Upgrade To Windows 10"
$UGButton.BackColor = "#D6CADD"
    $UGButton.Add_Click({$x=Update-MDT;$form.Close()})
$form.Controls.Add($UGButton)

$CLButton = New-Object System.Windows.Forms.Button
$CLButton.Location = New-Object System.Drawing.Point(300,100)
$CLButton.Size = New-Object System.Drawing.Size(200,150)
$CLButton.Text = "Clean Windows 10 Install"
$CLButton.BackColor = "#D6CADD"
    $CLButton.Add_Click({$x=Install-MDT;$form.Close()})
$form.Controls.Add($CLButton)

    $form.Add_Shown({$form.Activate()})   
$result = $form.ShowDialog()
#END FORM
$x
