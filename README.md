## Arch OS Install

1. Check for internet

```
ip link
```

2. Partition the disk

```
cfdisk /dev/nvme0n1 # for example
```

| device | size | desc |
|---|---|---|
| /dev/nvme0n1p1 | 400M | boot |
| /dev/nvme0n1p2 | 4G | swap |
| /dev/nvme0n1p3 | rest of disk | fielsystem |

3. Format the partitions

```
mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

4. Mount the partitions

```
mount /dev/nvme0n1p3 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot/efi
swapon /dev/nvme0n1p2

# check that partitions are mounted correctly
lsblk
```

5. Install the base system

```
pacstrap /mnt base linux linux-firmware base-devel vim sof-firmware grub
```

6. Generate fstab

```
# make sure fstab looks good
genfstab /mnt

# append fstab to /mnt/etc/fstab
genfstab -U /mnt >> /mnt/etc/fstab
```

7. Chroot into the new system

```
arch-chroot /mnt
```

8. Set timezone

```
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
```

9. Set locale

```
vim /etc/locale.gen
# uncomment en_US.UTF-8 UTF-8
```

10. Set hostname

```
echo "cool-host-name" > /etc/hostname
```

11. Useradd

```
useradd -m -G wheel -s /bin/bash ttrreevvoorr
passwwd ttrreevvoorr
visudo
# uncomment the line that allows members of wheel to sudo
```

12. Setup stuff

```
systemctl enable NetworkManager
pacman -Syu lightdm lightdm-gtk-greeter xfce4
systemctl enable lightdm
```

13. grub install

```
grub-install /dev/nvme0n1
grub-mkconfig -o /boot/grub/grub.cfg
```

```
exit
reboot
```


## Installing packages

Deploy dotfiles and install packages

```
git clone https://github.com/ttrreevvoorr/dotfiles.git
./deploy.sh
./install.sh
```

---

## i3 + XFCE Configurations

### Session and Startup

#### Current Session
For xfwm4, click 'Immediately' and change it to the  'Never' option.
For xfdesktop, click 'Immediately' and change it to the 'Never' option


#### Keyboard Shortcuts
| Command                     | Shortcut       |
| --------------------------- | -------------- |
| xfce4-screenshooter -f      | Print          |
| xfce4-screenshooter -r      | Shift+Print    |
| xfce4-screenshooter -w      | Alt+Print      |

#### Application Autostart
Add i3 to the list of startup applications.

```
Name: i3
Description: Tiling Window Manager
Command: i3
```

Remove the existing desktop manager
```
sudo pacman -R xfwm4
sudo pacman -R xfdesktop # I think xfce4-screenshooter depends on this though so idk
```

Restart the machine: `sudo reboot`
