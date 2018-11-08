#creation disque de diff client *3
New-VHD -Path "C:\Hyper-V\VHD\Cli-01.vhdx" -ParentPath "C:\Hyper-V\Master\client_entreprise32 MASTER.vhdx" -Differencing
New-VHD -Path "C:\Hyper-V\VHD\Cli-02.vhdx" -ParentPath "C:\Hyper-V\Master\client_entreprise32 MASTER.vhdx" -Differencing
New-VHD -Path "C:\Hyper-V\VHD\Cli-03.vhdx" -ParentPath "C:\Hyper-V\Master\client_entreprise32 MASTER.vhdx" -Differencing


#creation disque de diff serveur *6
New-VHD -Path "C:\Hyper-V\VHD\Srv-01.vhdx" -ParentPath "C:\Hyper-V\Master\Master 2012.vhdx" -Differencing
New-VHD -Path "C:\Hyper-V\VHD\Srv-02.vhdx" -ParentPath "C:\Hyper-V\Master\Master 2012.vhdx" -Differencing
New-VHD -Path "C:\Hyper-V\VHD\Srv-03.vhdx" -ParentPath "C:\Hyper-V\Master\Master 2012.vhdx" -Differencing

New-VHD -Path "C:\Hyper-V\VHD\RTR-01.vhdx" -ParentPath "C:\Hyper-V\Master\Master 2012.vhdx" -Differencing
New-VHD -Path "C:\Hyper-V\VHD\RTR-02.vhdx" -ParentPath "C:\Hyper-V\Master\Master 2012.vhdx" -Differencing
New-VHD -Path "C:\Hyper-V\VHD\RTR-03.vhdx" -ParentPath "C:\Hyper-V\Master\Master 2012.vhdx" -Differencing