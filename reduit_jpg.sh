#!/bin/sh
# Name Reduire JPG
 
for file
do
	name=`echo ${file%.*}`
	convert -resize 50% -auto-orient -strip -define jpeg:extent=400kb -- "$file" ./"${name}".reduit.jpg
done
# Script appelé depuis l'explorateur de fichiers Thunar
# l'explorateur lui donne la liste des fichiers .JPG qui ont été sélectionnés
# par l'utilisateur, et ce script les réduit aux alentours de 400Kb
# (pour envoi par mail, etc...
