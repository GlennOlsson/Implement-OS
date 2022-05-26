# Set to lowest available loop number, and one above
loop_low=24
loop_high=25

loop_l="loop$loop_low"
loop_h="loop$loop_high"

mnt_pt="/mnt/glennos"

# Unmount potential existing
#sudo losetup -d /dev/$loop_l
#sudo losetup -d /dev/$loop_h

# Create img file
sudo dd if=/dev/zero of=out/glennOS.img bs=512 count=131072
sudo parted out/glennOS.img mklabel msdos
sudo parted out/glennOS.img mkpart primary fat32 2048s 30720s
sudo parted out/glennOS.img set 1 boot on
sudo losetup /dev/$loop_l out/glennOS.img
sudo losetup /dev/$loop_h out/glennOS.img -o 1048576
sudo mkdosfs -F32 -f 2 /dev/$loop_h
sudo mount /dev/$loop_h $mnt_pt
sudo grub-install --root-directory=$mnt_pt --no-floppy --modules="normal part_msdos ext2 multiboot" /dev/$loop_l

# Move config and kernel files into fat disk
sudo cp grub.cfg $mnt_pt/boot/grub/
sudo cp out/kernel.bin $mnt_pt/boot/

# unmount disk, data is still saved in glennOS.img
sudo umount $mnt_pt
sudo losetup -d /dev/$loop_l
sudo losetup -d /dev/$loop_h
