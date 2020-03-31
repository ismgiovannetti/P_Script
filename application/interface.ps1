#Auteur: Ismael Giovannetti
#Date: 27.03.2020
#Modif:

function GenerateForm
{
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
##Création de l'objet Form
$frmMain = New-Object System.Windows.Forms.Form
#------------------------------

##Création d'une variable "Size"
$FormSize = New-Object System.Drawing.Size
$FormSize.Height = 500
$FormSize.Width = 800
$frmMain.ClientSize = $FormSize
#------------------------------

##Propriété de la Form
$frmMain.FormBorderStyle = 'FixedSingle'
#Permet oui ou non de mettre en fullscreen
$frmMain.MaximizeBox = $true
#$frmMain.DataBindings.DefaultDataSourceUpdateMode = 0
$frmMain.Name = "frmMain"
$frmMain.Text = [system.environment]::MachineName
#------------------------------

#Nom de la machine
$lblMachineName = New-Object System.Windows.Forms.Label
$lblMachineName.Location = New-Object System.Drawing.Point(10,20)
$lblMachineName.AutoSize = $true
$lblMachineName.Text = "Nom: "+[system.environment]::MachineName
$frmMain.Controls.Add($lblMachineName)
#------------------------------

#Ram
$lblRam = New-Object System.Windows.Forms.Label
$lblRam.Location = New-Object System.Drawing.Point(10,40)
$lblRam.AutoSize = $true
$Taille_RAM_MAX=[STRING]((Get-WmiObject -Class Win32_ComputerSystem ).TotalPhysicalMemory/1GB)
$lblRam.Text = "Ram: "+ $Taille_RAM_MAX
$frmMain.Controls.Add($lblRam)
#------------------------------

#Carte Graphique
$lblVideoController = New-Object System.Windows.Forms.Label
$lblVideoController.Location = New-Object System.Drawing.Point(10,60)
$lblVideoController.AutoSize = $true
$VideoControllerName = wmic path win32_VideoController get Name
$VideoControllerResolution = wmic path win32_VideoController get CurrentHorizontalResolution
$VideoControllerResolution += wmic path win32_VideoController get CurrentVerticalResolution
$lblVideoController.Text = "Carte graphique: `n"+ $VideoControllerName + "`n" + $VideoControllerResolution
$frmMain.Controls.Add($lblVideoController)
#------------------------------

#User
#$i = 0
$lblUser = New-Object System.Windows.Forms.Label
$lblUser.Location = New-Object System.Drawing.Point(10,90)
$lblUser.AutoSize = $true
$InfoUser = Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" | select name, fullname
$lblUser.Text = "User: " + $InfoUser.Name + " "
#Foreach ($Name in $InfoUser.Name)
#{
#$lblUserName + i++ = New-Object System.Windows.Forms.Label
#$lblUserName.Location = New-Object System.Drawing.Point(10,(90 + $i))
#$lblUserName.Text = $Name
#}
$frmMain.Controls.Add($lblUser)
#------------------------------

#Génération de la Form
$frmMain.add_Load($OnLoadForm_StateCorrection)
$frmMain.ShowDialog()| Out-Null 
#------------------------------
}
GenerateForm

