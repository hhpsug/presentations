# ESXCLI -V2

$VMHost = $VMHosts | select -First 1
$Datastore =  $VMHost | Get-Datastore -Name $TempDatastoreName
$HostPath = $Datastore.ExtensionData.Info.Url.remove(0,5) + $LocalPath.Split("\")[-1]

## Install-VMhost
Install-VMHostPatch -VMHost $VMHost -HostPath $HostPath

## ESXCLI V2
$esxcli2 = Get-ESXCLI -VMHost $VMhost -V2

### List
$esxcli2.software.vib.list.Invoke() | FT -AutoSize

### Install
$CreateArgs = $esxcli2.software.vib.install.CreateArgs()
$CreateArgs.depot = $HostPath
$InstallResponse = $esxcli2.software.vib.install.Invoke($CreateArgs)