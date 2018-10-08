# PSDrive
[String]$LocalPath = "C:\Users\Markus\Google Drive\PSUG HH\VMW-ESX-6.0.0-igbn-1.4.6-offline_bundle-9909123.zip"
[String]$TempDatastoreName = "*local"
 
[Array]$VMhosts = Get-VMHost
 
 $VMhosts.ForEach({
    $Datastore =  $_| Get-Datastore -Name $TempDatastoreName
    $DatastoreDriveName = "HostStore_" + $_.Name.Split(".")[0]
    $Datastore | New-DatastoreDrive -Name $DatastoreDriveName | Out-Null
    Copy-DatastoreItem -Item $LocalPath -Destination $($DatastoreDriveName + ":\") -Force:$true -Confirm:$false

    Remove-PSDrive -Name $DatastoreDriveName
    })