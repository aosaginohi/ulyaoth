
 <# Require the package and password name as parameter to build #>
 param (
    [string]$package = $(throw "-package is required."),
    [string]$password = $(throw "-password is required.")
 )
 
"CHECK 0: a valid parameter was provide ($package) and a password was provided."

 <# Set all required variables. #>
 $userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::PowerShell

<# check if the ulyaoth directory exist and if not then create it #>
if(!(Test-Path -Path c:\ulyaoth))
  {
   new-item c:\ulyaoth -itemtype directory
   "The directory 'c:\ulyaoth' was created."
  }
else
  {
   "CHECK 1: ulyaoth directory already exists"
  }
  
  <# check if the plink application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\plink.exe))
  {
   Invoke-WebRequest -uri https://trash.ulyaoth.net/trash/exe/putty/0.63/plink.exe -Method Get -OutFile c:\ulyaoth\plink.exe -UserAgent $userAgent
   "The program plink was downloaded."
  }
else
  {
   "CHECK 2: putty program is already available"
  }
  
  <# check if the psftp application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\psftp.exe))
  {
   Invoke-WebRequest -uri https://trash.ulyaoth.net/trash/exe/putty/0.63/psftp.exe -Method Get -OutFile c:\ulyaoth\psftp.exe
   "The program psftp was downloaded."
  }
else
  {
   "CHECK 3: psftp program is already available"
  }
  
 
 
<# Create the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" clonevm cc41ec2f-7aae-47d9-a910-70b02b71d535 --name f19rpmx64 --mode all --options keepallmacs --register

<# Start Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm f19rpmx64
  
<# Sleep for 60 seconds so machine can boot #>
Start-Sleep -Seconds 60

<# ssh into the machine and test it works #>
& Echo Y | "C:\ulyaoth\plink.exe" -ssh root@192.168.1.72 -pw $password "ls -l"

<# Delete the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm f19rpmx64 poweroff

<# Sleep for 30 seconds so machine can poweroff #>
Start-Sleep -Seconds 30

<# Poweroff the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unregistervm --delete f19rpmx64

