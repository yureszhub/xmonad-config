#!/bin/bash 
#####################################################################
# (c) 2013 Benjamín Albiñana Pérez
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

# Instalar translate con "sudo pip install translate"

TRANSLATE="/usr/local/bin/translate"
DZEN2="/usr/bin/dzen2"

$TRANSLATE -t es "$1" | $DZEN2 -p 4
