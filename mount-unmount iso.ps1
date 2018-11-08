#Récupérer les données dans Powershell

#"foreach ($VM in $VMs){


#$VMNAME = $VM.Nom #Nom de la VM!!!!!(aussi utilisé pour le VHD)!!!!!!!!
#$nbnicvoulue = $VM.NICs # définir le nombre de carte voulue
#$nbnicactuel = 1
#"$Gen = $VM.Generation  # Generation

#$VHDPath = "C:\Hyper-V\HDD\$VMNAME.VHDX"

#$StartRAM = 1GB # Bien spécifier GB ou MB
#[INT64] $RAMMinisaisi = $VM.RAMMinimum # Bien spécifier GB ou MB
#$RAMMini = $RAMMinisaisi *1MB
#$NBProc = 2 # Nombre de processeurs 

# Créer Vm - tout n'est pas possible lors de cette phase
#New-VM -Name $VMNAME -VHDPath  $VHDPath -Generation $Gen -MemoryStartupBytes $StartRAM  

# Suite à la création de la Vm, définir les paramètres dessus

#Set-VM -Name $VMNAME  -DynamicMemory -MemoryMinimumBytes $RAMMini -ProcessorCount $NBProc

# si besoin, ajouter les cartes réseau :
# Une VM a toujours une carte réseau, définir le nombre de carte actuel à 1
# définir le nombre de carte voulues
# $nbnicvoulue = 2

#While ($nbnicactuel -lt $nbnicvoulue){
#un peu d'affichage pour suivre ce qu'il se passe
#Write-Host "Nous avons actuellement $nbnicactuel cartes"
#"Write-Host "Nous ajoutons une carte"

# Faire l'action
#Add-VMNetworkAdapter -VMName $VMNAME

#Incrémenter le nombre de carte actuel
#$nbnicactuel++

## un peu d'affichage
#Write-Host "Nous avons maintenant $nbnicactuel cartes"
#}


$VMs = Import-Csv $PSScriptRoot\VMs.csv -Delimiter ","

foreach ($VM in $VMs){


$VMNAME = $vm.Nom 
$vhdroot = "c:\hyper-v\VHD\"
$confroot = "c:\hyper-v\conf\"
$vhdpath = $vhdroot + $VMNAME +".vhdx"


$vhdpath

Mount-VHD $vhdpath
Start-Sleep 5

$vhdparts = Get-VHD $vhdpath | Get-Partition

$thepartitionwewant = $vhdparts | Sort-Object size -Descending | Select-Object -First 1

$volcible = $thepartitionwewant.DriveLetter

$unattendSource = ("c:\Hyper-V\Confs\") + "FullUnattend-2012.xml"
$unattendDest = $volcible + ":\Windows\Panther\unattend.xml"

# Cependant la source depend du type de client - ici on se base sur le com de la vm
if ($VMNAME -like "CLI*") {
$unattendSource = $confroot + "FullUnattend-Win10.xml"
} Else {
$unattendSource = $confroot + "FullUnattend-2012.xml"
}



copy $unattendSource $unattendDest

# Conf + Deploy (sur les serveurs)

if ($VMNAME -notlike "CLI*") {
$destinationconf = $volcible + ":\conf"
$confsource = $confroot + "conf-" + "$VMNAME.ps1"
$scriptconf = $confroot + "deploy.cmd"


md $destinationconf
copy $confsource ($destinationconf +"\conf.ps1")
copy $scriptconf ($destinationconf +"\deploy.cmd")
}
Dismount-VHD $vhdpath
pause
}