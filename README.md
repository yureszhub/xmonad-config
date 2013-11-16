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
tmux gmrun i3lock git links2 vim-nox xdg-utils
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

##Atajos de teclado
<pre>
shift-alt-l         lanza el salvapantallas
alt-right           espacio de trabajo siguiente
alt-left            espacio de trabajo anterior
alt-up              subir el volumen de sonido
alt-down            bajar el volumen de sonido
shift-alt-enter     lanzar una terminal
alt-p               lanzar dmenu
shift-alt-p         lanzar gmrun
shfit-alt-c         cierra la ventana actual
alt-space           va rotando entre los distintos algoritmos de distribución 
shift-alt-space     reinicia el esquema del espacio de trabajo actual al por defecto
alt-n               cambia las ventanas al tamaño correcto
alt-tab             mueve el foco a la ventana siguiente
alt-j               mueve el foco a la ventana anterior
alt-k               mueve el foco a la ventana anterior
alt-m               mueve el foco a la ventana maestra
alt-enter           convierte la ventana con foco en la ventana maestra
shift-alt-j         cambia el foco con la ventana siguiente
shift-alt-k         cambia el foco con la ventana anterior
alt-h               encoge el área maestra
alt-l               estira el área maestra
alt-t               devuelve una venta flotante al esquema en uso 
alt-q               salir de xmonad
shift-alt-q         reiniciar xmonad
alt-g               scratchpad
</pre>

##Pantallazos
![xmonad al inicio](/benalb/xmonad-config/raw/master/images/clean.png)

![xmonad en acción](/benalb/xmonad-config/raw/master/images/xvt.png)
