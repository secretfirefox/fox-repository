# This script was written by Secret Firefox.
# Use this to install my custom setup of Void Linux.
# At the end, you should have a functional GNOME install. 
# Enjoy!
# PS: run the flatpak install script only after you are in the desktop session!

# Ensure the system is up to date 

sudo xbps-install -Suy 
sudo xbps-install -uy xbps
sudo xbps-install -Suy

# Add the non-free repository

sudo xbps-install -Rs void-repo-nonfree -y

# Install dbus, elogind, and Network Manager

sudo xbps-install dbus elogind NetworkManager -y 

# Turn off dhcpcd and wpa_supplicant in favor of NetworkManager

sudo sv stop dhcpcd wpa_supplicant
sudo touch /etc/sv/dhcpcd/down /etc/sv/wpa_supplicant/down
sudo sv status dhcpcd wpa_supplicant

# Enable dbus, elogind and Network Manager

sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/elogind /var/service
sudo ln -s /etc/sv/NetworkManager /var/service

# Install some recommended packages

sudo xbps-install curl wget git xz unzip zip nano vim gptfdisk xtools mtools mlocate ntfs-3g fuse-exfat bash-completion linux-headers gtksourceview4 ffmpeg mesa-vdpau mesa-vaapi htop neofetch numlockx 7zip psmisc cpupower ibus ibus-mozc -y

# Install some development packages (optional but recommended)

sudo xbps-install autoconf automake bison m4 make libtool flex meson ninja optipng sassc -y

# Install some important xdg utilities, to allow communication between apps

sudo xbps-install xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-gnome xdg-user-dirs xdg-user-dirs-gtk xdg-utils -y

# Install PulseAudio and Pipewire/Wireplumber

sudo xbps-install pulseaudio pulseaudio-utils pulsemixer alsa-plugins-pulseaudio pipewire wireplumber -y

# Install cronie and enable its service

sudo xbps-install cronie -y 
sudo ln -s /etc/sv/cronie /var/service

# Install a logging daemon

sudo xbps-install socklog-void -y
sudo ln -s /etc/sv/socklog-unix /var/service/
sudo ln -s /etc/sv/nanoklogd /var/service/

# Install Profile Sync Daemon, to speed up browsers

git clone https://github.com/madand/runit-services
cd runit-services
sudo mv psd /etc/sv/
sudo ln -s /etc/sv/psd /var/service/
sudo chmod +x /etc/sv/psd/*

# Install Firefox and set a better font for it

sudo xbps-install firefox firefox-i18n-en-US -y
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo xbps-reconfigure -f fontconfig 

# Run some xdg-utilities to make GTK apps appear more ready

xdg-user-dirs-update
xdg-user-dirs-gtk-update

# Install wayland and xorg display servers

sudo xbps-install xorg wayland -y

# Install the GNOME Desktop Environment

sudo xbps-install gnome gdm -y

# Install gnome-browser-connector (chrome-gnome-shell)

sudo xbps-install gnome-browser-connector

# Enable the Gnome Display Manager (GDM)

sudo ln -s /etc/sv/gdm /var/service

#  Inform finished install

echo "Installation finished, please reboot the computer."
