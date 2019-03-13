# Init

## Import VMware Modules
Get-Module -Name VMware* -ListAvailable | Import-Module

## Connect vCenter
Connect-VIServer vcenter-01.lab.local

## Prepare VMs
$sourceVMName = "test"

For ($i=1; $i -le 20; $i++) {
    $newVMName = [String]($sourceVMName + $i)
    New-VM -Name $newVMName -VM $sourceVMName -VMHost "esxi-01.lab.local" -Datastore "vol_vmware_01" -DiskStorageFormat Thin
    }

