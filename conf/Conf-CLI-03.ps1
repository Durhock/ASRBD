# Gestion des cartes

# Renommer les Cartes (1 cartes)

Rename-NetAdapter -Name "Ethernet" -NewName "Bou-Lan"

# Config

netsh int ip set ad ARC-CLI source=static 192.168.128.2/24
netsh int ip set dns ARC-CLI source=static 8.8.8.8 validate=no


# Brasser (peut être fait à n'importe quel moment) - sur Hyperviseur.

# Forwarding

netsh int ip set int ARC-SRV for=en

# Routes

route add -p 0.0.0.0/0 192.168.255.254


# Pare-Feu

Enable-NetFirewallRule -Name *erq-in

# Installer role

# Install-WindowsFeature Routing -IncludeManagementTools

# Renommer Windows

Rename-Computer CLI-03