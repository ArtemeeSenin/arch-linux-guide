sudo pacman -S xorg xorg-init xorg-server xorg-apps xterm
sudo pacman -S plasma kde-applications sddm

Xorg :0 -configure

sudo systemctl enable sddm.service

sudo ip link set wlo1 up
sudo systemctl enable NetworkManager

sudo pacman -S firefox git xf86-video-intel mesa

git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri
