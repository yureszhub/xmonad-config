#!/usr/bin/env python
# -*- coding: UTF-8 -*-
#####################################################################
# (c) 2011 Benjamín Albiñana Pérez
# benalb@gmail.com
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#

#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
# 0. You just DO WHAT THE FUCK YOU WANT TO.
####################################################################
from random import choice

lista = []
try:
    f = open("TODO.txt", "r")
    for i in f.readlines():
        if len(i) > 2:
            lista.append(i.strip())
    f.close()

    try:
        print choice(lista)
    except IndexError:
        print "No hay nada pendiente"
except IOError:
    print "No existe el fichero TODO.txt"
