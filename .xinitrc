source $HOME/.profile &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
xrdb -merge $HOME/.Xdefaults &
numlockx &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0xa9a9a9 --height 12 &
xsetroot -cursor_name left_ptr &
#xcompmgr -c -t-5 -l-5 -r4.2 -o.25 &
sh $HOME/.fehbg &
$HOME/.dropbox-dist/dropboxd &
exec ck-launch-session xmonad
