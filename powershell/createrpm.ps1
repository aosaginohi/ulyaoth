
 <# Require the package, password, repouser and repopass name as parameter to build #>
 param (
    [string]$package = $(throw "-package is required."),
    [string]$password = $(throw "-password is required."),
    [string]$repouser = $(throw "-repouser is required."),
    [string]$repopass = $(throw "-repopass is required.")
 )
 
 <# Set all required variables. #>
 $userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer

<# Set the correct build variable based on package input #>
If ($package -eq ulyaoth-nginx | ulyaoth-nginx-pagespeed | ulyaoth-nginx-modsecurity | ulyaoth-nginx-naxsi-masterbuild | ulyaoth-nginx-passenger4 | ulyaoth-nginx-passenger5 | ulyaoth-kibana4 | ulyaoth-tomcat6 | ulyaoth-tomcat7 | ulyaoth-tomcat8 | ulyaoth-tomcat6-admin | ulyaoth-tomcat7-admin | ulyaoth-tomcat8-admin | ulyaoth-tomcat6-docs | ulyaoth-tomcat7-docs | ulyaoth-tomcat8-docs | ulyaoth-tomcat6-examples | ulyaoth-tomcat7-examples | ulyaoth-tomcat8-examples | ulyaoth-tomcat-native | ulyaoth-logstah-forwarder-masterbuild | ulyaoth-fcgiwrap | ulyaoth-hhvm)
{
  $build = 'wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-rpm-build.sh ; chmod +x ulyaoth-rpm-build.sh ; ./ulyaoth-rpm-build.sh $package'
}
Else
{
  "Only a supported Ulyaoth repository package can be used as input."
  exit
} 
 
"CHECK 0: a valid parameter was provide ($package)."
 
 
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
"Sleeping 60 seconds while waiting for the Virtual Machine to boot."

<# ssh into the machine and start the rpm build process #>
echo y | C:\ulyaoth\plink.exe -ssh root@192.168.1.72 -pw $password '$build'

<# Sleep for 5 minutes by default to build the package or 2 hours if building hhvm #>
If ($package -eq ulyaoth-hhvm)
{
Start-Sleep -Seconds 7200
'Sleeping for 2 hours while waiting for the Virtual Machine to build the rpm for $package.'
}
Else
{
Start-Sleep -Seconds 300
'Sleeping for 5 minutes while waiting for the Virtual Machine to build the for $package.'
}

<# Poweroff the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm f19rpmx64 poweroff

<# Sleep for 30 seconds so machine can poweroff #>
Start-Sleep -Seconds 30
"Sleeping 30 seconds while waiting for the Virtual Machine to poweroff."

<# Delete the Fedora 19 64bit virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unregistervm --delete f19rpmx64

