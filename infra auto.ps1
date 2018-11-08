$VMs = Import-Csv $PSScriptRoot\VMs.csv -Delimiter ","

#Boucler dans le tableau en cherchant les information qui nous interessent

foreach ($VM in $VMs){


$VMNAME = $VM.Nom #Nom de la VM!!!!!(aussi utilisé pour le VHD)!!!!!!!!
$nbnicvoulue = $VM.NICs # définir le nombre de carte voulue
$nbnicactuel = 1
$Gen = $VM.Generation  # Generation

$VHDPath = "C:\Hyper-V\VHD\$VMNAME.VHDX"

$StartRAM = 1GB # Bien spécifier GB ou MB
[INT64] $RAMMinisaisi = $VM.RAMMinimum # Bien spécifier GB ou MB
$RAMMini = $RAMMinisaisi *1MB
$NBProc = 2 # Nombre de processeurs 

# Créer Vm - tout n'est pas possible lors de cette phase
New-VM -Name $VMNAME -VHDPath  $VHDPath -Generation $Gen -MemoryStartupBytes $StartRAM  

# Suite à la création de la Vm, définir les paramètres dessus

Set-VM -Name $VMNAME  -DynamicMemory -MemoryMinimumBytes $RAMMini -ProcessorCount $NBProc

# si besoin, ajouter les cartes réseau :
# Une VM a toujours une carte réseau, définir le nombre de carte actuel à 1
# définir le nombre de carte voulues
# $nbnicvoulue = 2

While ($nbnicactuel -lt $nbnicvoulue){
#un peu d'affichage pour suivre ce qu'il se passe
Write-Host "Nous avons actuellement $nbnicactuel cartes"
Write-Host "Nous ajoutons une carte"

# Faire l'action
Add-VMNetworkAdapter -VMName $VMNAME

#Incrémenter le nombre de carte actuel
$nbnicactuel++

# un peu d'affichage
Write-Host "Nous avons maintenant $nbnicactuel cartes"
}
}