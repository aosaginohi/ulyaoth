 <# Require the package name as parameter to build #>
 param (
    [string]$package = $(throw "-package is required.")
 )
 
"CHECK 0: a valid parameter was provide ($package)"

<# check if the ulyaoth directory exist and if not then create it #>
if(!(Test-Path -Path c:\ulyaoth))
  {
   new-item c:\ulyaoth -itemtype directory
  }
else
  {
   "CHECK 1: ulyaoth directory already exists"
  }
  
  <# check if the putty application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\putty.exe))
  {
   Invoke-WebRequest -uri https://trash.ulyaoth.net/trash/exe/putty/0.63/putty.exe -Method Get -OutFile c:\ulyaoth\putty.exe -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer)
  }
else
  {
   "CHECK 2: putty program is already available"
  }
  
  <# check if the psftp application exist and if not then download it #>
  if(!(Test-Path -Path c:\ulyaoth\psftp.exe))
  {
   Invoke-WebRequest -uri https://trash.ulyaoth.net/trash/exe/putty/0.63/psftp.exe -Method Get -OutFile c:\ulyaoth\psftp.exe -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer)
  }
else
  {
   "CHECK 3: psftp program is already available"
  }
  
  
  
  