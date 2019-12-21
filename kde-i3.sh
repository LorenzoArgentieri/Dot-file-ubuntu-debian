#!/bin/bash
set -e
echo -e '#!/bin/sh/\n\nKDEWM=/usr/bin/i3 startkde' > /usr/local/bin/startkde-i3
sudo chown root.staff /usr/local/bin/startkde-i3
sudo chmod 755 /usr/local/bin/startkde-i3

sudo cp -a /usr/share/xsessions /usr/local/share/xsessions

cp /usr/local/share/xsessions/plasma.desktop /usr/local/share/xsessions/plasma-i3.desktop
sudo sed -i 's|/usr/bin/startkde|/usr/local/bin/startkde-i3|' /usr/local/share/xsessions/plasma-i3.desktop
sudo sed -i '/Name.*=/ s/$/-i3/' /usr/local/share/xsessions/plasma-i3.desktop
echo -e '\n\n[X11]\nSessionDir=/usr/local/share/xsessions' | sudo tee -a /etc/sddm.conf

cat ./i3conf >> $HOME/.config/i3/config
