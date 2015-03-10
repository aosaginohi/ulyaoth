
<# Require the package, password, repouser and repopass name as parameter to build #>
param (
  [string]$package = $(throw "-package is required."),
  [string]$password = $(throw "-password is required."),
  [string]$repouser = $(throw "-repouser is required."),
  [string]$repopass = $(throw "-repopass is required.")
)
 
<# Set all required variables. #>
$PackageArray = @("ulyaoth-nginx", "ulyaoth-nginx-pagespeed", "ulyaoth-nginx-modsecurity", "ulyaoth-nginx-naxsi-masterbuild", "ulyaoth-nginx-passenger4", "ulyaoth-nginx-passenger5", "ulyaoth-kibana4", "ulyaoth-tomcat6", "ulyaoth-tomcat7", "ulyaoth-tomcat8", "ulyaoth-tomcat6-admin", "ulyaoth-tomcat7-admin", "ulyaoth-tomcat8-admin", "ulyaoth-tomcat6-docs", "ulyaoth-tomcat7-docs", "ulyaoth-tomcat8-docs", "ulyaoth-tomcat6-examples", "ulyaoth-tomcat7-examples", "ulyaoth-tomcat8-examples", "ulyaoth-tomcat-native", "ulyaoth-logstah-forwarder-masterbuild", "ulyaoth-fcgiwrap", "ulyaoth-hhvm")
$MachineArray = @{ 'cc41ec2f-7aae-47d9-a910-70b02b71d535' = '192.168.1.91'; 'b' = 2; 'c' = 3}

<# Set the correct build variable based on package input #>
if ($PackageArray -contains $package)
{
  $build = "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-rpm-build.sh ; chmod +x ulyaoth-rpm-build.sh ; ./ulyaoth-rpm-build.sh $package"
}
Else
{
  "Only a supported Ulyaoth repository package can be used as input."
  exit
} 
 
"CHECK 0: a valid parameter was provide ($package)."
 
 
<# check if the ulyaoth directory exist and if not then create it #>
if(!(Test-Path -Path c:\ulyaoth\createrpm))
  {
   new-item c:\ulyaoth\createrpm -itemtype directory
   "The directory 'c:\ulyaoth\createrpm' was created."
  }
else
  {
   "CHECK 1: c:\ulyaoth\createrpm  directory already exists"
  }
  
  <# check if the plink application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\createrpm\plink.exe))
  {
   Invoke-WebRequest -uri https://trash.ulyaoth.net/trash/exe/putty/0.63/plink.exe -Method Get -OutFile c:\ulyaoth\createrpm\plink.exe
   "The program plink was downloaded."
  }
else
  {
   "CHECK 2: putty program is already available"
  }
  
  <# check if the psftp application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\createrpm\psftp.exe))
  {
   Invoke-WebRequest -uri https://trash.ulyaoth.net/trash/exe/putty/0.63/psftp.exe -Method Get -OutFile c:\ulyaoth\createrpm\psftp.exe
   "The program psftp was downloaded."
  }
else
  {
   "CHECK 3: psftp program is already available"
  }

ForEach ($buildbox in $MachineArray.GetEnumerator()) {
{
<# Create the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" clonevm $buildbox.Name --name buildmachine --mode all --options keepallmacs --register
"Creating the virtual machine"

<# If we build ulyaoth-hhvm then give the server more ram and cpus #>
If ($package -Match "ulyaoth-hhvm")
{
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm buildmachine --vram 8192 --cpus 4
"We are building $package so increasing Memory to 8GB and cpus to 4."
}

<# Start the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm buildmachine
"Starting the virtual machine"
  
<# Sleep for 60 seconds so machine can boot #>
Start-Sleep -Seconds 60
"Sleeping 60 seconds while waiting for the Virtual Machine to boot."

<# ssh into the machine and start the rpm build process #>
echo y | c:\ulyaoth\createrpm\plink.exe -ssh root@$buildbox.Value -pw $password "$build"
"Running the build script on: $buildbox.Name"

<# Sleep for 5 minutes by default to build the package or 2 hours if building hhvm #>
If ($package -Match "ulyaoth-hhvm")
{
Start-Sleep -Seconds 7200
"Sleeping for 2 hours while waiting for the Virtual Machine to build the rpm for $package."
}
Else
{
Start-Sleep -Seconds 300
"Sleeping for 5 minutes while waiting for the Virtual Machine to build the rpm for $package."
}

<# Poweroff the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm buildmachine poweroff
"Stopping the virtual machine"

<# Sleep for 30 seconds so machine can power off #>
Start-Sleep -Seconds 30
"Sleeping 30 seconds while waiting for the Virtual Machine to power off."

<# Delete the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unregistervm --delete buildmachine
"Deleting the virtual machine"

<# Sleep for 10 seconds before looping again #>
Start-Sleep -Seconds 10
"Sleeping 10 seconds just to make sure the delete operation is finished."
}
