# Gestion des cartes

# Renommer les Cartes (2 cartes)

Rename-NetAdapter -Name "Ethernet" -NewName "WAN"
Rename-NetAdapter -Name "Ethernet 2" -NewName "Arc-SRV"
Rename-NetAdapter -Name "Ethernet 3" -NewName "Arc-CLI"

# Config

netsh int ip set ad Arc-SRV source=static 192.168.8.254/24
netsh int ip set ad WAN source=static 192.168.255.8/24
netsh int ip set ad Arc-CLI source=static 192.168.12.254/24
netsh int ip set dns WAN source=Static 8.8.8.8

# Brasser (peut être fait à n'importe quel moment) - sur Hyperviseur.

# Forwarding

netsh int ip set int WAN for=en
netsh int ip set int Arc-CLI for=en
netsh int ip set int Arc-SRV for=en


# Routes

route add -p 0.0.0.0/0 192.168.255.254
route add -p 192.168.128.0/24 192.168.255.128



# Pare-Feu

Enable-NetFirewallRule -Name *erq-in

# Installer role


# Renommer Windows

Rename-Computer RTR-01 -Restart