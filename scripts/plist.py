#!/usr/bin/env python
# -*- coding: UTF-8 -*-
#####################################################################
# (c) 2012 Benjamín Albiñana Pérez
# benalb@gmail.com
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
# 0. You just DO WHAT THE FUCK YOU WANT TO.
####################################################################

import os
from random import sample
import subprocess
import tempfile

DIR = "/home/benalb/music/"


def listaficheros():
    """Devuelve una lista de ficheros que cumplen la condición
    de ser mp3. La lista es una muestra aleatoria, cuyo número
    es configurable"""
    lista = [os.path.join(raiz, fichero)
            for raiz, carpetas, ficheros in os.walk(DIR)
            for fichero in ficheros
            if fichero.endswith(".mp3")]
    return sample(lista, 20)


def doplaylist():
    """Devuelve un fichero temporal para usar como lista de
    reproducción por mplayer"""
    playlist = tempfile.NamedTemporaryFile(delete=False)
    for cancion in listaficheros():
        playlist.write(cancion + '\n')
    playlist.seek(0)
    return playlist


def main():
    """función principal"""
    player = ['mplayer', "-playlist", doplaylist().name]
    return subprocess.Popen(player,
            stdout=subprocess.PIPE).communicate()[0]

if __name__ == '__main__':
    main()
