sudo pacman -S xorg xorg-init xorg-server xorg-apps xorg-utils xterm
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
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
echo "node" > .nvmrc # to default to the latest version

echo -e 'export NVM_DIR="$HOME/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm\n[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' > ~/.zshrc
#install langs'
#install bluetooth
