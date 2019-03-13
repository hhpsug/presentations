# VM UUID "DeepDive" 

function Get-VMID {

  [CmdletBinding()]
    param( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$True, Position=0)]
        	[VMware.VimAutomation.ViCore.Impl.V1.Inventory.InventoryItemImpl[]]
        	$myVMs
    )
Process { 

	$MyView = @()
	ForEach ($myVM in $myVMs){
		$UUIDReport = [PSCustomObject] @{
				Name = $myVM.name 
				UUID = $myVM.extensiondata.Config.UUID
				InstanceUUID = $myVM.extensiondata.config.InstanceUUID
				LocationID = $myVM.extensiondata.config.LocationId
				MoRef = $myVM.extensiondata.Moref.Value
				}
		$MyView += $UUIDReport
		}
	$MyView
	}
}

function Convert-UUID {
    ## http://blog-stack.net/convert-windows-uuid-to-vmware-vmx-uuid-format/
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateNotNullorEmpty()]
        [String]$UUIDwin
    )
    
    $0,$1,$2,$3,$4 = $UUIDwin.Split("-")
    [Array]$UUIDBlocks = [String]$UUIDwin.Split("-")
    [Array]$Block0Split = $0 -split '(..)' | Where-Object { $_ }
    [array]::Reverse($Block0Split)
    $Block0 = $Block0Split -join('')
    
    [Array]$Block1Split = $1 -split '(..)' | Where-Object { $_ }
    [array]::Reverse($Block1Split)
    $Block1 = $Block1Split -join('')
    
    [Array]$Block2Split = $2 -split '(..)' | Where-Object { $_ }
    [array]::Reverse($Block2Split)
    $Block2 = $Block2Split -join('')
    
    [String]$UUID = ($Block0 + "-" + $Block1 + "-" + $Block2 + "-" + $3 + "-" + $4).ToLower()
    
    return $UUID
    
    }
    
## Match OS and VMware UUID 

### Get BIOS UUID from Wiondows OS
$code =@'
(Get-WmiObject Win32_ComputerSystemProduct).UUID
'@

$user = 'local\administrator'
$pswd = 'Anfang!!'
$sPswd = ConvertTo-SecureString -String $pswd -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user,$sPswd
 
$sInvP = @{
   VM = 'Veeam-03'
   ScriptType = 'PowerShell'
   GuestOSType = 'Windows'
   ScriptText = $code
   GuestCredential = $cred
}
### Prepare Output
Remove-Variable UUIDwin, UUIDreturn -ErrorAction SilentlyContinue
$UUIDreturn = Invoke-VMScriptPlus @sInvP
[String]$UUIDwin = $UUIDreturn.ScriptOutput

### Output
Convert-UUID -UUIDwin $UUIDwin
Get-VM -Name "Veeam-03" | Get-VMID | select UUID
