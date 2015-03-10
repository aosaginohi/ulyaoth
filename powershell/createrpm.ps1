
 <# Require the package, password, repouser and repopass name as parameter to build #>
 param (
    [string]$package = $(throw "-package is required."),
    [string]$password = $(throw "-password is required."),
	[string]$repouser = $(throw "-repouser is required."),
	[string]$repopass = $(throw "-repopass is required.")
 )
 
"CHECK 0: a valid parameter was provide ($package) and a password was provided."

 <# Set all required variables. #>
 $userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer

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
  
 <# Set the correct build variable based on package input #>
 If ($package -eq ulyaoth-nginx)
 {
   $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/build-ulyaoth-nginx.sh ; chmod +x build-ulyaoth-nginx.sh ; ./build-ulyaoth-nginx.sh"
 }
 ElseIf ($package -eq ulyaoth-nginx-pagespeed)
 {
   $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/build-ulyaoth-nginx-pagespeed.sh ; chmod +x build-ulyaoth-nginx-pagespeed.sh ; ./build-ulyaoth-nginx-pagespeed.sh"
 }
 ElseIf ($package -eq ulyaoth-nginx-modsecurity)
 {
   $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/build-ulyaoth-nginx-modsecurity.sh ; chmod +x build-ulyaoth-nginx-modsecurity.sh ; ./build-ulyaoth-nginx-modsecurity.sh"
 }
 ElseIf ($package -eq ulyaoth-nginx-naxsi-masterbuild)
 {
   $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/build-ulyaoth-nginx-naxsi-masterbuild.sh ; chmod +x build-ulyaoth-nginx-naxsi-masterbuild.sh ; ./build-ulyaoth-nginx-naxsi-masterbuild.sh"
 }
 ElseIf ($package -eq ulyaoth-nginx-passenger4)
 {
   $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/build-ulyaoth-nginx-passenger4.sh ; chmod +x build-ulyaoth-nginx-passenger4.sh ; ./build-ulyaoth-nginx-passenger4.sh"
 }
  ElseIf ($package -eq ulyaoth-nginx-passenger5)
 {
   $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/build-ulyaoth-nginx-passenger5.sh ; chmod +x build-ulyaoth-nginx-passenger5.sh ; ./build-ulyaoth-nginx-passenger5.sh"
 }
 Else
{
 "Only a supported Ulyaoth repository package can be used as input."
 exit
}

 
 
<# Create the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" clonevm cc41ec2f-7aae-47d9-a910-70b02b71d535 --name f19rpmx64 --mode all --options keepallmacs --register

<# Start Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm f19rpmx64
  
<# Sleep for 60 seconds so machine can boot #>
Start-Sleep -Seconds 60
"Sleeping 60 seconds while waiting for the Virtual Machine to boot."

<# ssh into the machine and test it works #>
echo y | C:\ulyaoth\plink.exe -ssh root@192.168.1.72 -pw $password '$build'

<# Sleep for 5 minutes to build the package #>
Start-Sleep -Seconds 300
"Sleeping for 5 minutes while waiting for the Virtual Machine to build the rpm."

<# Delete the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm f19rpmx64 poweroff

<# Sleep for 30 seconds so machine can poweroff #>
Start-Sleep -Seconds 30
"Sleeping 30 seconds while waiting for the Virtual Machine to poweroff."

<# Poweroff the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unregistervm --delete f19rpmx64

