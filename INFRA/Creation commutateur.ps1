New-VMSwitch -Name 'Arc-CLI' -SwitchType Private 
New-VMSwitch -Name 'Arc-SRV' -SwitchType Private
New-VMSwitch -Name 'Bou-Lan' -SwitchType Private
New-VMSwitch -Name 'WAN' -SwitchType Private
New-VMSwitch -Name "octopus" -SwitchType Private
New-VMSwitch -name "Salle" -NetAdapterName "ethernet"  -AllowManagementOs $true
pause

Get-VMNetworkAdapter * | Connect-VMNetworkAdapter -SwitchName octopus

## demarer les vm pr ip
#pause sleep 5

Get-VMNetworkAdapter * | where ipaddresses -like "192.168.8.*" | Connect-VMNetworkAdapter -SwitchName Arc-Srv
Get-VMNetworkAdapter * | where ipaddresses -like "192.168.128.*" | Connect-VMNetworkAdapter -SwitchName Bou-Lan 
Get-VMNetworkAdapter * | where ipaddresses -like "192.168.255.*" | Connect-VMNetworkAdapter -SwitchName WAN
Get-VMNetworkAdapter * | where ipaddresses -like "192.168.12.*" | Connect-VMNetworkAdapter -SwitchName Arc-cli
#Get-VMNetworkAdapter * | where ipaddresses -like "10.*" | Connect-VMNetworkAdapter -SwitchName Salle
#salle chope octopus- tri par type mayb
pause
Get-VMNetworkAdapter * | where SwitchName -like "octopus" | Connect-VMNetworkAdapter -SwitchName Arc-Cli
#routeur 3
pause
Remove-VMSwitch -Name "octopus"

