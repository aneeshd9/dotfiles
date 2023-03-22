# killall trayer
killall nm-applet
killall variety
killall xfce4-power-manager
killall picom
killall blueman-applet
killall volumeicon

trayer --edge top --align right --SetDockType true --SetPartialStrut true\
  --expand true --monitor 1 --transparent true --alpha 0 --height 24\
  --widthtype request --padding 6 --tint 0x282c34 &

xfce4-power-manager &

nm-applet --sm-disable &

picom &

volumeicon &

variety &

blueman-applet &

