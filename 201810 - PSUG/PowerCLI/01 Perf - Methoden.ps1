# Perf - Methoden / Get-View mit Filter

## Init Array of VMs
$VMs = Get-VM 

## Where-Object Cmdlet
Measure-Command { $VMs | Where-Object {$_.Name -eq "test"} }

## Where Methode 
Measure-Command { $VMs.Where({$_.Name -eq "test"}) }

## Where Split 
$VMsOn, $VMsOff = $VMs.Where({$_.PowerState -eq "PoweredOn"}, "Split")
$VMsOn.Count
$VMsOff.Count

## Get-View mit Filter gegen Get-VM mit Where-Object
Measure-Command {Get-VM -Name "test" | fl}
Measure-Command {Get-View -ViewType VirtualMachine -Filter @{Name="^test"} | fl}