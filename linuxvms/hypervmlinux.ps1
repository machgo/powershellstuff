$newvmname = "kube03"
$oldvmname = "ub1804"
Import-VM -Path 'C:\templates\ub1804\Virtual Machines\EABC8881-4906-4E60-AD6F-4D029B5587D9.vmcx' -Copy -GenerateNewId
get-vm $oldvmname | set-vm -NewVMName $newvmname -MemoryMinimumBytes 2gb -MemoryStartupBytes 2gb
get-vm $newvmname | Disable-VMTPM
mv  "D:\Hyper-V\Virtual Hard Disks\$($oldvmname).vhdx" "D:\Hyper-V\Virtual Hard Disks\$($newvmname).vhdx"
get-vm $newvmname | Get-VMHardDiskDrive | Set-VMHardDiskDrive -Path "D:\Hyper-V\Virtual Hard Disks\$($newvmname).vhdx"