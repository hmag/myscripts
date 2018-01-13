#!/bin/bash
# Force le disque dur à ne pas se mettre en standby
# ce qui pose problème au système (qui s'appuie sur
# un disque qui met trop de temps à répondre, et le système
# se gèle...)
# Fait à l'arrache, en utilisant /dev/sda ... 
# idéalement il faudrait rechercher la partition /
# et trouver le bon /dev correspondant...
# nécessite sudo apt-get install hdparm smartmontools
sudo smartctl -d sat -s standby,0 /dev/sda

