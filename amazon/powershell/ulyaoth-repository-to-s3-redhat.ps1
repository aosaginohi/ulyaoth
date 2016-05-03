#Red Hat:
#Delete the old repodata folder.
Remove-Item S:\redhat\6Server\i386\debug\repodata -recurse
Remove-Item S:\redhat\6Server\i386\os\repodata -recurse
Remove-Item S:\redhat\6Server\i386\source\repodata -recurse
Remove-Item S:\redhat\6Server\x86_64\debug\repodata -recurse
Remove-Item S:\redhat\6Server\x86_64\os\repodata -recurse
Remove-Item S:\redhat\6Server\x86_64\source\repodata -recurse
Remove-Item S:\redhat\7Server\x86_64\debug\repodata -recurse
Remove-Item S:\redhat\7Server\x86_64\os\repodata -recurse
Remove-Item S:\redhat\7Server\x86_64\source\repodata -recurse

#Delete the old repoview folder.
Remove-Item S:\redhat\6Server\i386\debug\repoview -recurse
Remove-Item S:\redhat\6Server\i386\os\repoview -recurse
Remove-Item S:\redhat\6Server\i386\source\repoview -recurse
Remove-Item S:\redhat\6Server\x86_64\debug\repoview -recurse
Remove-Item S:\redhat\6Server\x86_64\os\repoview -recurse
Remove-Item S:\redhat\6Server\x86_64\source\repoview -recurse
Remove-Item S:\redhat\7Server\x86_64\debug\repoview -recurse
Remove-Item S:\redhat\7Server\x86_64\os\repoview -recurse
Remove-Item S:\redhat\7Server\x86_64\source\repoview -recurse

#Copy the new repodata folder.
Copy-Item R:\Repository\RPMs\redhat\6Server\i386\debug\repodata S:\redhat\6Server\i386\debug -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\i386\os\repodata S:\redhat\6Server\i386\os -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\i386\source\repodata S:\redhat\6Server\i386\source -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\x86_64\debug\repodata S:\redhat\6Server\x86_64\debug -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\x86_64\os\repodata S:\redhat\6Server\x86_64\os -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\x86_64\source\repodata S:\redhat\6Server\x86_64\source -recurse
Copy-Item R:\Repository\RPMs\redhat\7Server\x86_64\debug\repodata S:\redhat\7Server\x86_64\debug -recurse
Copy-Item R:\Repository\RPMs\redhat\7Server\x86_64\os\repodata S:\redhat\7Server\x86_64\os -recurse
Copy-Item R:\Repository\RPMs\redhat\7Server\x86_64\source\repodata S:\redhat\7Server\x86_64\source -recurse

#Copy the new repoview folder.
Copy-Item R:\Repository\RPMs\redhat\6Server\i386\debug\repoview S:\redhat\6Server\i386\debug -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\i386\os\repoview S:\redhat\6Server\i386\os -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\i386\source\repoview S:\redhat\6Server\i386\source -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\x86_64\debug\repoview S:\redhat\6Server\x86_64\debug -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\x86_64\os\repoview S:\redhat\6Server\x86_64\os -recurse
Copy-Item R:\Repository\RPMs\redhat\6Server\x86_64\source\repoview S:\redhat\6Server\x86_64\source -recurse
Copy-Item R:\Repository\RPMs\redhat\7Server\x86_64\debug\repoview S:\redhat\7Server\x86_64\debug -recurse
Copy-Item R:\Repository\RPMs\redhat\7Server\x86_64\os\repoview S:\redhat\7Server\x86_64\os -recurse
Copy-Item R:\Repository\RPMs\redhat\7Server\x86_64\source\repoview S:\redhat\7Server\x86_64\source -recurse

#Copy the latest rpms to S3.
get-childitem "R:\Repository\RPMs\redhat\6Server\i386\debug\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\6Server\i386\debug"
get-childitem "R:\Repository\RPMs\redhat\6Server\i386\os\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\6Server\i386\os"
get-childitem "R:\Repository\RPMs\redhat\6Server\i386\source\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\6Server\i386\source"
get-childitem "R:\Repository\RPMs\redhat\6Server\x86_64\debug\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\6Server\x86_64\debug"
get-childitem "R:\Repository\RPMs\redhat\6Server\x86_64\os\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\6Server\x86_64\os"
get-childitem "R:\Repository\RPMs\redhat\6Server\x86_64\source\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\6Server\x86_64\source"
get-childitem "R:\Repository\RPMs\redhat\7Server\x86_64\debug\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\7Server\x86_64\debug"
get-childitem "R:\Repository\RPMs\redhat\7Server\x86_64\os\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\7Server\x86_64\os"
get-childitem "R:\Repository\RPMs\redhat\7Server\x86_64\source\*.rpm" | where-object {$_.LastWriteTime -gt (get-date).AddDays(-1)} | Copy-Item -destination "S:\redhat\7Server\x86_64\source"