pacman -S xorg xorg-init xorg-server xorg-apps xorg-utils xterm
pacman -S plasma kde-applications sddm

Xorg :0 -configure
cp /root/xorg.conf.new /etc/X11/xorg.conf

echo "exec startkde" > ~/.xinitrc
systemctl enable sddm.service
systemct disable dhcpcd

pacman -S xf86-input-synaptics xf86-video-intel mesa alsa-utils alsa-plugins

reboot

# Log in and install software

sudo systemctl enable NetworkManager 

sudo ip link set wlo1 up
sudo systemctl enable NetworkManager

sudo pacman -S firefox git

# pikaur
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri

#install jetbrains-toolbox
pikaur -S jetbrains-toolbox --noconfirm

# telegram
pikaur -S telegram-desktop --noconfirm

# zsh
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install --latest-npm
echo "node" > .nvmrc

echo -e 'export NVM_DIR="$HOME/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm\n[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' > ~/.zshrc
# lang switching
setxkbmap -layout us,ru -option 'grp:caps_toggle,grp_led:caps'
setxkbmap -layout us,ru -option 'grp:alt_shift_toggle'

#install bluetooth
sudo pacman -S bluez bluez-utils blueman pulseaudio pulseaudio-bluetooth

# fonts
pikaur -S powerline-fonts
curl -L https://github.com/caarlos0/msfonts/raw/master/install.sh | sudo sh
