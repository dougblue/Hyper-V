# Define the VM names
$vmNames = @('VM1', 'VM2', 'VM3', 'VM4', 'VM5')

# Path to the VHDX, checkpoint, and snapshot files
$vhdxPath = 'H:\trident dev\'
$switch = 'Trident Network A switch'
$isoPath = "C:\Users\Administrator\Downloads\OSDCloud_NoPrompt.iso"

# Loop through each VM name and create the VM
foreach ($vmName in $vmNames) {
#    Get-VM -Name $vmNames
#Specify vhdx,checkpoint,and configuration file paths 
    $vhdxDir = $vhdxPath + $vmName+'\Vhdx\Main.vhdx'
    $checkpointDir = $vhdxPath + $vmName+'\Checkpoint'
    $configDir = $vhdxPath + $vmName+'\Config'
    #check if they exist | if folder-path is true| Return "Vm paths already exists"
    write-host The virtual drive path is $vhdxDir
    write-host Checkpoints will be stored at $checkpointDir
    write-host Config files will be stored at $configDir

    # Create the VM
    New-VM -Name $vmName -MemoryStartupBytes 2GB -SwitchName $switch -NewVHDPath $vhdxDir -NewVHDSizeBytes 42949672960 -Path $configDir -Generation 2 -Force
    
    # Add other configurations here if needed, such as network adapter, CPU, etc.
    $vm = Get-VM -Name $vmName
    
    $DVD = Add-VMDvdDrive -VMName $vm.VMName -Path $isoPath -Passthru
 
    Set-VMFirmware -VM $VM -FirstBootDevice $DVD

    # Start the VM
    #Start-VM -Name $vmName
}
