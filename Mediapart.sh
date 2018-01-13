#!/bin/bash
# Script pour récupérer les articles sur le site de mediapart.fr
# 	en faire un epub
#	l'envoyer par mail
#	en garder une copie en local
#	en déposer une copie dans le cloud (hubic)
# Pré-requis :
#	calibre (pour le traitement des fichier recipe générant l'epub)
#	mutt (pour envoyer le mail)
#	rclone (pour recopier sur hubic)
#	avoir le fichier Mediapart.recipe dans le répertoire de lancement
#	avoir le fichier Mediapart.sh.env dans le répertoire de lancement
# Répertoire de destination :
REPDEST="/tmp/"
HORO=`date "+%Y%m%d-%H%M%S"`
#Fichier epub cible :
FILDEST=$REPDEST"Mediapart."$HORO".epub"
#Fichier de log qui servira de corps de mail 
FILLOG="/tmp/Mediapart."$HORO".log"
#Répertoire pour garder une copie du fichier epub généré
REPBACK="/home/shared/shared/Mediapart/"
#Répertoire "cloud" pour déposer une copie du fichier epub généré
REPCLOUD="Hubic1:default/Mediapart"
#Répertoire de ce script 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#Nom de ce script
SCRIPTNAME=${0##*/}
#Fichier contenant les variables d'environnement nécessaires à l'exécution (login, password, ..)
ENVFILE=$DIR/$SCRIPTNAME.env
if [ ! -f $ENVFILE ]; then
	echo "Le fichier des variables d'environnement est introuvable !"
	exit 1
fi
. $ENVFILE
export EMAIL=$MEDIAPART_EMAIL_FROM
echo `date +%Y-%m-%d--%H:%M:%S` "Debut du traitement Mediapart." >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "Variables : " >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Répertoire de sortie : REPDEST = $REPDEST" >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Horodatage HORO = $HORO" >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Fichier destination FILDEST = $FILDEST" >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Fichier de log FILLOG = $FILLOG" >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Repertoire pour recopier l'epub REPBACK = $REPBACK" >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Recopie cloud REPCLOUD = $REPCLOUD" >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` "     Login sur le site de Mediapart = $MEDIAPART_LOGIN" >> $FILLOG 2>> $FILLOG

# POUR LA MISE A JOUR DE LA RECETTE :
# La recette (recipe) pour récupérer le flux de Mediapart vient de :
# https://raw.githubusercontent.com/kovidgoyal/calibre/master/recipes/mediapart.recipe
# pour mettre à jour la recette :
# wget -O Mediapart.recipe https://raw.githubusercontent.com/kovidgoyal/calibre/master/recipes/mediapart.recipe
#
#
# Récupérer un epub depuis Mediapart :
/usr/bin/ebook-convert "Mediapart.recipe" $FILDEST --username=$MEDIAPART_LOGIN --password=$MEDIAPART_PASSWORD >> $FILLOG 2>> $FILLOG

# Sauvegarde de l'epub sur le répertoire partagé :

echo `date +%Y-%m-%d--%H:%M:%S` " Sauvegarde du fichier epub dans $REPBACK" >> $FILLOG 2>> $FILLOG
cp $FILDEST $REPBACK >> $FILLOG 2>> $FILLOG
# Sauvegarde de l'epub sur le cloud :
echo `date +%Y-%m-%d--%H:%M:%S` " Synchronisation du répertoire $REPBACK avec le cloud $REPCLOUD" >> $FILLOG 2>> $FILLOG
/home/johe/bin/rclone sync $REPBACK $REPCLOUD >> $FILLOG 2>> $FILLOG
echo `date +%Y-%m-%d--%H:%M:%S` " Fin de la synchronisation cloud, et envoi du fichier par mail" >> $FILLOG 2>> $FILLOG

# Et l'envoyer par mail :
/usr/bin/mutt -s "Mediapart du jour" -a $FILDEST -- $MEDIAPART_EMAIL_DEST < $FILLOG
rm /home/johe/sent
