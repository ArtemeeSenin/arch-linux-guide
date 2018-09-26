sudo pacman -S xorg xorg-init xorg-server xorg-apps xterm
sudo pacman -S plasma kde-applications sddm

Xorg :0 -configure

echo "exec startkde" > ~/.xinitrc
sudo systemctl enable sddm.service
sudo systemct disable dhcpcd

sudo pacman -S xf86-input-synaptics xf86-video-intel mesa

reboot

sudo systemctl enable NetworkManager 

sudo ip link set wlo1 up
sudo systemctl enable NetworkManager

sudo pacman -S firefox git

git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri

#install jetbrains-toolbox
#install nvm
#install langs
#install bluetooth
