
#AMAZONLINUX:
#Delete the old repodata folder.
Remove-Item S:\amazonlinux\latest\x86_64\debug\repodata -recurse
Remove-Item S:\amazonlinux\latest\x86_64\os\repodata -recurse
Remove-Item S:\amazonlinux\latest\x86_64\source\repodata -recurse

#Delete the old repoview folder.
Remove-Item S:\amazonlinux\latest\x86_64\debug\repoview -recurse
Remove-Item S:\amazonlinux\latest\x86_64\os\repoview -recurse
Remove-Item S:\amazonlinux\latest\x86_64\source\repoview -recurse

#Copy the new repodata folder.
Copy-Item R:\Repository\RPMs\amazonlinux\latest\x86_64\debug\repodata S:\amazonlinux\latest\x86_64\debug -recurse
Copy-Item R:\Repository\RPMs\amazonlinux\latest\x86_64\os\repodata S:\amazonlinux\latest\x86_64\os -recurse
Copy-Item R:\Repository\RPMs\amazonlinux\latest\x86_64\source\repodata S:\amazonlinux\latest\x86_64\source -recurse

#Copy the new repoview folder.
Copy-Item R:\Repository\RPMs\amazonlinux\latest\x86_64\debug\repoview S:\amazonlinux\latest\x86_64\debug -recurse
Copy-Item R:\Repository\RPMs\amazonlinux\latest\x86_64\os\repoview S:\amazonlinux\latest\x86_64\os -recurse
Copy-Item R:\Repository\RPMs\amazonlinux\latest\x86_64\source\repoview S:\amazonlinux\latest\x86_64\source -recurse

#Copy the latest rpms to S3.
get-childitem "R:\Repository\RPMs\amazonlinux\latest\x86_64\debug\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\amazonlinux\latest\x86_64\debug"
get-childitem "R:\Repository\RPMs\amazonlinux\latest\x86_64\os\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\amazonlinux\latest\x86_64\os"
get-childitem "R:\Repository\RPMs\amazonlinux\latest\x86_64\source\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\amazonlinux\latest\x86_64\source"