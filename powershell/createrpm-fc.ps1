
<# Require the package, password, repouser and repopass name as parameter to build #>
param (
  [string]$package = $(throw "-package is required."),
  [string]$password = $(throw "-password is required."),
  [string]$repouser = $(throw "-repouser is required."),
  [string]$repopass = $(throw "-repopass is required."),
  [string]$repo = $(throw "-repo is required."),
  [string]$port = $(throw "-port is required.")
)
 
<# Set all required variables. #>
$PackageArray = @("ulyaoth-lua5.3", "ulyaoth-varnish5", "ulyaoth-haproxy1.3", "ulyaoth-haproxy1.4", "ulyaoth-haproxy1.5", "ulyaoth-haproxy1.6", "ulyaoth-beats", "ulyaoth-screen", "ulyaoth-tmux", "ulyaoth-leveldb", "ulyaoth-nginx-stable-and-mainline-module-naxsi", "ulyaoth-nginx-stable-and-mainline-module-devel-kit", "ulyaoth-nginx-stable-and-mainline-module-headers-more", "ulyaoth-nginx-stable-and-mainline-module-form-input", "ulyaoth-nginx-stable-and-mainline-module-pam", "ulyaoth-nginx-stable-and-mainline-module-echo", "ulyaoth-nginx-stable-and-mainline-module-encrypted-session", "ulyaoth-nginx-stable-and-mainline-module-array-var", "ulyaoth-kafka-manager", "ulyaoth-smtpping", "ulyaoth-httping", "ulyaoth-terraform", "ulyaoth-solr6-examples", "ulyaoth-solr6-docs", "ulyaoth-solr6", "ulyaoth-fuse-s3fs", "ulyaoth-fuse", "ulyaoth-vegeta", "ulyaoth-kafka8-scala2.9.1", "ulyaoth-kafka8-scala2.9.2", "ulyaoth-kafka8-scala2.10", "ulyaoth-kafka8-scala2.11", "ulyaoth-kafka9-scala2.10", "ulyaoth-kafka9-scala2.11", "ulyaoth-wolfssl", "ulyaoth-go", "ulyaoth-openssl1.1.0", "ulyaoth-openssl1.0.2", "ulyaoth-openssl1.0.1", "ulyaoth-openssl1.0.0", "ulyaoth-openssl0.9.8", "ulyaoth-apr", "ulyaoth-packetbeat", "ulyaoth-topbeat", "ulyaoth-filebeat", "ulyaoth-logstash", "ulyaoth-zookeeper3.4", "ulyaoth-zookeeper3.5", "ulyaoth-jsvc", "ulyaoth-tomcat-multi", "ulyaoth-redis3", "ulyaoth-nginx-mainline-naxsi", "ulyaoth-nginx-naxsi", "ulyaoth-hiawatha", "ulyaoth-mbedtls", "ulyaoth-mbedtls2.1", "ulyaoth-mbedtls2.2", "ulyaoth-mbedtls2.3", "ulyaoth-mbedtls2.4", "ulyaoth-monkey", "ulyaoth-nginx-passenger4", "ulyaoth-nginx-passenger4-selinux", "ulyaoth-nginx-mainline-passenger4", "ulyaoth-nginx-mainline-passenger4-selinux", "ulyaoth-nginx-passenger5", "ulyaoth-nginx-passenger5-selinux", "ulyaoth-nginx-mainline-passenger5", "ulyaoth-nginx-mainline-passenger5-selinux", "ulyaoth-tengine-development-selinux", "ulyaoth-tengine-development", "ulyaoth-tengine-selinux", "ulyaoth-tengine", "ulyaoth-httpdiff", "ulyaoth-solr5-examples", "ulyaoth-solr5-docs", "ulyaoth-solr5", "ulyaoth-solr4", "ulyaoth-banana", "spotify", "ulyaoth", "ulyaoth-nginx", "ulyaoth-nginx-mainline", "ulyaoth-nginx-pagespeed", "ulyaoth-nginx-mainline-pagespeed", "ulyaoth-nginx-pagespeed-selinux", "ulyaoth-nginx-mainline-pagespeed-selinux", "ulyaoth-nginx-modsecurity", "ulyaoth-nginx-naxsi-masterbuild", "ulyaoth-nginx-mainline-naxsi-masterbuild", "ulyaoth-nginx-ironbee-masterbuild", "ulyaoth-kibana4", "ulyaoth-tomcat6", "ulyaoth-tomcat7", "ulyaoth-tomcat8", "ulyaoth-tomcat8.5", "ulyaoth-tomcat9", "ulyaoth-tomcat6-admin", "ulyaoth-tomcat7-admin", "ulyaoth-tomcat8-admin", "ulyaoth-tomcat8.5-admin", "ulyaoth-tomcat6-docs", "ulyaoth-tomcat7-docs", "ulyaoth-tomcat8-docs", "ulyaoth-tomcat8.5-docs", "ulyaoth-tomcat6-examples", "ulyaoth-tomcat7-examples", "ulyaoth-tomcat8-examples", "ulyaoth-tomcat8.5-examples", "ulyaoth-tomcat-native", "ulyaoth-tomcat-native1.2", "ulyaoth-logstash-forwarder", "ulyaoth-fcgiwrap", "ulyaoth-hhvm")
$MachineArray = @{ 'cc41ec2f-7aae-47d9-a910-70b02b71d535' = '192.168.1.100'; '111bc301-86f8-4fb7-bf49-3d143fb69ba7' = '192.168.1.102'; '4fd05e17-169c-4835-8716-088142f2c3b8' = '192.168.1.104'; 'a705a5d7-9d97-454b-b683-c478afc9f67c' = '192.168.1.106'; 'ced4ecfc-6d6d-4d68-9881-96a0b0753411' = '192.168.1.120'; 'b4ee95fa-dbbb-4527-9a15-1e49cc093682' = '192.168.1.123' }

<# Set the correct build variable based on package input #>
if ($PackageArray -contains $package)
{
  $build = "wget https://raw.githubusercontent.com/ulyaoth/repository/master/ulyaoth-rpm-build.sh ; chmod +x ulyaoth-rpm-build.sh ; ./ulyaoth-rpm-build.sh -b $package -u $repouser -r $repo -p $port"
}
Else
{
  "Only a supported Ulyaoth repository package can be used as input."
  exit
} 
 
"CHECK 0: a valid package parameter was provide ($package)."
 
 
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
   Invoke-WebRequest -uri https://downloads.ulyaoth.net/exe/putty/0.63/plink.exe -Method Get -OutFile c:\ulyaoth\createrpm\plink.exe
   "The program plink was downloaded."
  }
else
  {
   "CHECK 2: putty program is already available"
  }
  
  <# check if the psftp application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\createrpm\psftp.exe))
  {
   Invoke-WebRequest -uri https://downloads.ulyaoth.net/exe/putty/0.63/psftp.exe -Method Get -OutFile c:\ulyaoth\createrpm\psftp.exe
   "The program psftp was downloaded."
  }
else
  {
   "CHECK 3: psftp program is already available"
  }

ForEach ($buildbox in $MachineArray.GetEnumerator()) 
{
<# Create the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" clonevm $buildbox.Name --name buildmachine-fc-$package --mode all --options keepallmacs --register
"Creating the virtual machine"

<# Start the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm buildmachine-fc-$package --type headless
"Starting the virtual machine"
  
<# Sleep for 60 seconds so machine can boot #>
"Sleeping 60 seconds while waiting for the Virtual Machine to boot."
Start-Sleep -Seconds 60

<# ssh into the machine and start the rpm build process #>
"Running the build script"
echo y | c:\ulyaoth\createrpm\plink.exe -ssh -l root $buildbox.Value -pw $password "$build"

<# Poweroff the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm buildmachine-fc-$package poweroff
"Stopping the virtual machine"

<# Sleep for 15 seconds so machine can power off #>
"Sleeping 15 seconds while waiting for the Virtual Machine to power off."
Start-Sleep -Seconds 15

<# Delete the virtual machine #>
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unregistervm --delete buildmachine-fc-$package
"Deleting the virtual machine"

<# Sleep for 10 seconds before looping again #>
"Sleeping 10 seconds just to make sure the delete operation is finished."
Start-Sleep -Seconds 10
}
