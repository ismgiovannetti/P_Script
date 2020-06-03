#Auteur: Ismael Giovannetti - Tiago Ferreira - Jérémy Deslile - Daniel Gil
#Date: 03.06.2020
#Modif: 03.06.2020

#Fonctions Boutons
function ShowUser
{
$InfoUser = Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" | Select PSComputername, Name, Status, Disabled, AccountType, Lockout, PasswordRequired, PasswordChangeable | Out-GridView
#------------------------------
}
function ShowGPU
{
$InfoGPU = Get-WmiObject -Class win32_VideoController | Select Name, CurrentHorizontalResolution, CurrentVerticalResolution, Status | Out-GridView
}
function ShowDrive
{
 $Status_all_disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"| Select SystemName,DeviceID,VolumeName,@{Name="Taille(Go)";Expression={"{0:N1}"-f($_.size/1GB)}},@{Name="Espace Restant(Go)";Expression={"{0:N1}"-f($_.freespace/1GB)}} | Out-GridView
}
function ShowRam
{
$InfoGPU = Get-WmiObject -Class Win32_physicalmemory | Select Name, Capacity, ConfiguredClockSpeed | Out-GridView
}

function ShowCPU
{
$InfoGPU = Get-WmiObject -Class Win32_processor | Select Name, LoadPercentage, CurrentClockSpeed,Availability | Out-GridView
}
function ShowStart
{
$InfoGPU = Get-CimInstance -ClassName Win32_StartupCommand | Select-Object -Property Name | Out-GridView
}
#---------------------

#evenement boutons 
$btnUser_OnClick= 
{
    ShowUser
}
$btnGPU_OnClick= 
{
    ShowGPU   
}
$btnDrive_OnClick= 
{
    ShowDrive   
}
$btnRam_OnClick= 
{
    ShowRam   
}
$btnCPU_OnClick= 
{
    ShowCPU   
}
$btnStart_OnClick= 
{
    ShowStart  
}
#--------------------
function GenerateForm
{
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
##Création de l'objet Form
$frmMain = New-Object System.Windows.Forms.Form
#------------------------------

##Création d'une variable "Size"
$FormSize = New-Object System.Drawing.Size
$FormSize.Height = 350
$FormSize.Width = 240
$frmMain.ClientSize = $FormSize
#------------------------------

##Propriété de la Form
$frmMain.FormBorderStyle = 'FixedSingle'
#Permet oui ou non de mettre en fullscreen
$frmMain.MaximizeBox = $false
#$frmMain.DataBindings.DefaultDataSourceUpdateMode = 0
$frmMain.Name = "frmMain"
$frmMain.Text = [system.environment]::MachineName
#------------------------------

#Nom de la machine
$lblMachineName = New-Object System.Windows.Forms.Label
$lblMachineName.Location = New-Object System.Drawing.Point(65,30)
$lblMachineName.AutoSize = $true
$lblMachineName.Text = [system.environment]::MachineName
$frmMain.Controls.Add($lblMachineName)
#------------------------------


#Bouton User
$btnUser = New-Object System.Windows.Forms.Button
$btnUser.Location = New-Object System.Drawing.Point(80,70)
$btnUser.AutoSize = $true
$btnUser.Text = "User"
$btnUser.add_Click($btnUser_OnClick)
$frmMain.Controls.Add($btnUser)

#------------------------------

#Bouton GPU
$btnGPU = New-Object System.Windows.Forms.Button
$btnGPU.Location = New-Object System.Drawing.Point(80,110)
$btnGPU.AutoSize = $true
$btnGPU.Text = "GPU"
$btnGPU.add_Click($btnGPU_OnClick)
$frmMain.Controls.Add($btnGPU)

#------------------------------

#Bouton Disque
$btnDrive = New-Object System.Windows.Forms.Button
$btnDrive.Location = New-Object System.Drawing.Point(80,150)
$btnDrive.AutoSize = $true
$btnDrive.Text = "Drive"
$btnDrive.add_Click($btnDrive_OnClick)
$frmMain.Controls.Add($btnDrive)

#------------------------------

#Bouton Ram
$btnRam = New-Object System.Windows.Forms.Button
$btnRam.Location = New-Object System.Drawing.Point(80,190)
$btnRam.AutoSize = $true
$btnRam.Text = "Ram"
$btnRam.add_Click($btnRam_OnClick)
$frmMain.Controls.Add($btnRam)

#------------------------------


#Bouton CPU
$btnCPU = New-Object System.Windows.Forms.Button
$btnCPU.Location = New-Object System.Drawing.Point(80,230)
$btnCPU.AutoSize = $true
$btnCPU.Text = "CPU"
$btnCPU.add_Click($btnCPU_OnClick)
$frmMain.Controls.Add($btnCPU)
#------------------------------

#Bouton Start
$btnStart = New-Object System.Windows.Forms.Button
$btnStart.Location = New-Object System.Drawing.Point(80,270)
$btnStart.AutoSize = $true
$btnStart.Text = "Start"
$btnStart.add_Click($btnStart_OnClick)
$frmMain.Controls.Add($btnStart)
#------------------------------

#Génération de la Form
$frmMain.add_Load($OnLoadForm_StateCorrection)
$frmMain.ShowDialog()| Out-Null 
#------------------------------
}
GenerateForm


