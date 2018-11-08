# Gestion des cartes

# Renommer les Cartes (2 cartes)

Rename-NetAdapter -Name "Ethernet" -NewName "WAN"
Rename-NetAdapter -Name "Ethernet 2" -NewName "Salle"

# Config

netsh int ip set ad Salle source=dhcp
netsh int ip set ad WAN source=static 192.168.255.254/24
netsh int ip set dns Salle static 9.9.9.9 validate=no

# Brasser (peut être fait à n'importe quel moment) - sur Hyperviseur.

# Forwarding

netsh int ip set int WAN for=en
netsh int ip set int Salle for=en

# Routes

route add -p 192.168.8.0/21 192.168.255.8
route add -p 192.168.128.0/24 192.168.255.128


# Pare-Feu

Enable-NetFirewallRule -Name *erq-in

# Installer role

Install-WindowsFeature Routing -IncludeManagementTools

# Renommer Windows

Rename-Computer RTR-03 -Restart