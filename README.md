#xmonad-config
Ficheros de configuración de [xmonad](http://xmonad.org), junto con
alguno de los dotfiles que utilizo. 

##¿Por qué? 
Aparte del componente exhibicionista (mira, mamá, estoy en github), la
idea es poder tener una instalación completamente funcional de xmonad en
menos de 20 minutos.

##¿Cómo?
Debian stable básica recien instalada. Como root hacemos:
<pre>
root@debian # apt-get install xmonad x11-xserver-utils xmobar trayer 
feh numlockx libghc-xmonad-contrib-dev rxvt-unicode xinit suckless-tools 
tmux gmrun i3lock git links2 vim
</pre>
y apt se ocupará de todas las dependencias.

Después, ya como usuario, hacemos:
<pre>
user@debian $ git clone git://github.com/benalb/xmonad-config.git
</pre>
y creamos los enlaces pertinentes. Ahora ya sólo queda ejecutar como
usuario:
<pre>
user@debian $ startx
</pre>


##Pantallazos
![xmonad al inicio](/benalb/xmonad-config/raw/master/images/clean.png)

![xmonad en acción](/benalb/xmonad-config/raw/master/images/xvt.png)
